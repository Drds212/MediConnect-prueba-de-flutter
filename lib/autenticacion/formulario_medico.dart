import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:prueba_2/autenticacion/login.dart';
import 'package:prueba_2/providers/medico_providers.dart';

class FormularioMedico extends StatefulWidget {
  const FormularioMedico({super.key});

  @override
  _FormularioMedicoState createState() => _FormularioMedicoState();
}

class _FormularioMedicoState extends State<FormularioMedico> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MediConnect",
          style: GoogleFonts.playball(
            textStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 45,
              color: Color(0xFF2DD1C7),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Consumer<MedicoProvider>(
            builder: (context, medicoProvider, child) {
              return Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ), 
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Formulario Médico',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2DD1C7),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Nombre',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa tu nombre';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          medicoProvider.updateNombre(value);
                        },
                      ),
                      SizedBox(height: 16.0),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Especialidad',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        items: medicoProvider.especialidades.map((
                          String especialidad,
                        ) {
                          return DropdownMenuItem<String>(
                            value: especialidad,
                            child: Text(especialidad),
                          );
                        }).toList(),
                        onChanged: (value) {
                          medicoProvider.updateEspecialidad(value);
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Por favor selecciona una especialidad';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Calificación (1–5)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa una calificación';
                          }
                          final double? calif = double.tryParse(value);
                          if (calif == null || calif < 1 || calif > 5) {
                            return 'La calificación debe estar entre 1 y 5';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          medicoProvider.updateCalificacion(
                            double.tryParse(value),
                          );
                        },
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa tu correo electrónico';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Por favor ingresa un correo electrónico válido';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          medicoProvider.updateEmail(value);
                        },
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Teléfono',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa tu número de teléfono';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          medicoProvider.updateTelefono(value);
                        },
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa tu contraseña';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          medicoProvider.updateContrasena(value);
                        },
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Fecha de Nacimiento (ej: 2001-01-01)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa tu fecha de nacimiento';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          medicoProvider.updateFechaNacimiento(value);
                        },
                      ),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 51, 172, 60),
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            await medicoProvider.submitForm(context);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PantallaLogin(),
                              ),
                            );
                          }
                        },
                        child: Text(
                          'Registrar',
                          style: TextStyle(color: Color(0xFFFFFFFF)),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
