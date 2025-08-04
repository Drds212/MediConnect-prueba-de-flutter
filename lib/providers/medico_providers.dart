import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Medico {
  String? nombre;
  String? especialidad;
  double? calificacion;
  String? email;
  String? telefono;
  String? contrasena;
  String? fechaNacimiento;
  final String tipo; 

  Medico({
    this.nombre,
    this.especialidad,
    this.calificacion,
    this.email,
    this.telefono,
    this.contrasena,
    this.fechaNacimiento,
    this.tipo = "doctor", 
  });
}

class MedicoProvider with ChangeNotifier {
  Medico _medico = Medico();

  final List<String> especialidades = [
    'Medicina General',
    'Pediatría',
    'Cardiología',
    'Dermatología',
    'Ginecología',
    'Oftalmología',
    'Psiquiatría',
  ];


  Medico get medico => _medico;

  void updateNombre(String nombre) {
    _medico.nombre = nombre;
    notifyListeners();
  }

  void updateEspecialidad(String? especialidad) {
    _medico.especialidad = especialidad;
    notifyListeners();
  }

  void updateCalificacion(double? calificacion) {
    _medico.calificacion = calificacion;
    notifyListeners();
  }

  void updateEmail(String email) {
    _medico.email = email;
    notifyListeners();
  }

  void updateTelefono(String telefono) {
    _medico.telefono = telefono;
    notifyListeners();
  }

  void updateContrasena(String contrasena) {
    _medico.contrasena = contrasena;
    notifyListeners();
  }

  void updateFechaNacimiento(String fechaNacimiento) {
    _medico.fechaNacimiento = fechaNacimiento;
    notifyListeners();
  }

  Future<void> submitForm(BuildContext context) async {
    final medicoData = {
      "name": _medico.nombre,
      "email": _medico.email,
      "phone": _medico.telefono,
      "password": _medico.contrasena,
      "type": _medico.tipo,
      "specialty": _medico.especialidad,
      "rating": _medico.calificacion,
      "birthdate": _medico.fechaNacimiento,
    };

    try {
      final response = await http.post(
        Uri.parse('http://164.92.126.218:3000/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(medicoData),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Médico registrado con éxito')),
        );
        _medico = Medico(); 
        notifyListeners();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al registrar médico')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error de conexión: $e')),
      );
    }
  }
}
