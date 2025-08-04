import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:prueba_2/pacientes/lista_medicos.dart';

class PantallaPaciente extends StatelessWidget {
  Future<List<Medico>> fetchMedicos() async {
    final response = await http.get(
      Uri.parse('http://164.92.126.218:3000/patients/doctors'),
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((medico) {
            return Medico(
              id: medico['id'] ?? 0,
              name: medico['name'] ?? 'Sin nombre',
              email: medico['email'] ?? 'Sin email',
              phone: medico['phone'] ?? 'Sin teléfono',
              specialty: medico['specialty'],
              rating: medico['rating']?.toDouble(),
            );
          })
          .where((medico) => medico.specialty != null)
          .toList();
    } else {
      throw Exception('Error al cargar médicos');
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
    
    body: FutureBuilder<List<Medico>>(
      future: fetchMedicos(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No hay médicos disponibles.'));
        }

        final medicos = snapshot.data!;

        return Column(
          children: [

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Médicos Disponibles",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2DD1C7), 
                ),
              ),
            ),
           
            Expanded(
              child: ListaMedicos(medicos: medicos),
            ),
          ],
        );
      },
    ),
  );
}

}

class Medico {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String? specialty;
  final double? rating;

  Medico({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.specialty,
    this.rating,
  });
}
