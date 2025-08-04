import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prueba_2/autenticacion/formulario_medico.dart';
import 'package:prueba_2/autenticacion/formulario_paciente.dart';

class TipoUsuario extends StatelessWidget {
  const TipoUsuario({super.key});

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(60.0),
              child: Text(
                "     Selecciona \nel tipo de usuario",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromARGB(255, 106, 211, 240),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FormularioMedico()),
                );
              },
              child: Text(
                'Registrarse como médico',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),

            SizedBox(height: 10),

            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Color(0xFF33AC3C),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FormularioPaciente()),
                );
              },
              child: Text(
                'Registrarse como paciente',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
