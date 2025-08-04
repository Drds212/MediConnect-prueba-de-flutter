import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prueba_2/pacientes/pantalla_pacientes.dart';

class PerfilMedico extends StatelessWidget {
  final Medico medico;

  const PerfilMedico({Key? key, required this.medico}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2DD1C7),
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
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Nombre: ${medico.name}',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text('Especialidad: ${medico.specialty ?? 'No disponible'}'),
                  SizedBox(height: 10),
                  Text(
                    'Calificación: ${medico.rating?.toString() ?? 'No disponible'}',
                  ),
                  SizedBox(height: 10),
                  Text('Email: ${medico.email}'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 68, 157, 64),
                      ),
                    ),
                    onPressed: () {
                      _showChatModal(context);
                    },
                    child: Text(
                      'Iniciar Chat',
                      style: TextStyle(color: Color(0xFFFFFFFF)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showChatModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Chat con ${medico.name}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('Esta función no está disponible en esta versión.'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cerrar'),
              ),
            ],
          ),
        );
      },
    );
  }
}
