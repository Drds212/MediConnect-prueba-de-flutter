import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:prueba_2/autenticacion/login.dart';

class FormularioPaciente extends StatefulWidget {
  const FormularioPaciente({super.key});

  @override
  State<StatefulWidget> createState() {
    return FormularioMedicoState();
  }
}

class FormularioMedicoState extends State<FormularioPaciente> {
  final _formKey = GlobalKey<FormState>();
  String? nombre;
  String? especialidad = "null";
  double? calificacion = 1;
  String? email;
  String? telefono;
  String? contrasena;
  String? fechaNacimiento;
  final String? tipo = "paciente";

  Future<void> submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final medicoData = {
        "name": nombre,
        "email": email,
        "phone": telefono,
        "password": contrasena,
        "type": tipo,
        "specialty": especialidad,
        "rating": calificacion,
        "birthdate": fechaNacimiento,
      };

      try {
        final response = await http.post(
          Uri.parse('http://164.92.126.218:3000/auth/register'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(medicoData),
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Paciente registrado con éxito')),
          );
          _formKey.currentState!.reset();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al registrar paciente')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error de conexión: $e')));
      }
    }
  }

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
    body: SingleChildScrollView( // <-- 1. Envuelve el cuerpo con SingleChildScrollView
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Registro de Pacientes',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2DD1C7),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              // Aquí van todos tus Padding y TextFormFields
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nombre',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa tu nombre';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    nombre = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
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
                    email = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Teléfono',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa tu número de teléfono';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    telefono = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
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
                    contrasena = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Fecha de Nacimiento (ej: 2001-01-01)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa tu fecha de nacimiento';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    fechaNacimiento = value;
                  },
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 68, 157, 64),
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    await submitForm(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PantallaLogin()),
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
      ),
    ),
  );
}
}
