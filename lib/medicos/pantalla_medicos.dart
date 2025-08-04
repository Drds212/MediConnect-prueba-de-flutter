import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PerfilMedico extends StatefulWidget {
  final int medicoId;

  const PerfilMedico({Key? key, required this.medicoId}) : super(key: key);

  @override
  _PerfilMedicoState createState() => _PerfilMedicoState();
}

class _PerfilMedicoState extends State<PerfilMedico> {
  late Future<List<Cita>> _citas;
  final TextEditingController _patientNameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  DateTimeRange? _selectedDateRange;

  @override
  void initState() {
    super.initState();
    _citas = fetchCitas(widget.medicoId);
  }

  Future<List<Cita>> fetchCitas(int medicoId) async {
    final response = await http.get(
      Uri.parse('http://164.92.126.218:3000/doctors/${medicoId}/appointments'),
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((cita) => Cita.fromJson(cita)).toList();
    } else {
      throw Exception('Error al cargar citas');
    }
  }

  Future<void> agregarCita() async {
    if (_patientNameController.text.isEmpty || _dateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, completa todos los campos.')),
      );
      return;
    }

    final response = await http.post(
      Uri.parse(
        'http://164.92.126.218:3000/doctors/${widget.medicoId}/appointments',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'patientName': _patientNameController.text,
        'date': _dateController.text,
      }),
    );

    if (response.statusCode == 200) {
      _patientNameController.clear();
      _dateController.clear();
      setState(() {
        _citas = fetchCitas(widget.medicoId);
      });
    } else {
      throw Exception('Error al agregar cita');
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
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Agendar Cita",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2DD1C7),
                    ),
                  ),
                  SizedBox(height: 19),
                  TextField(
                    controller: _patientNameController,
                    decoration: InputDecoration(
                      labelText: 'Nombre del Paciente',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color(0xFF2DD1C7)),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _dateController,
                    decoration: InputDecoration(
                      labelText: 'Fecha (ej: 2001-01-01)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color(0xFF2DD1C7)),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 68, 157, 64),
                          ),
                        ),
                        onPressed: agregarCita,
                        child: Text(
                          'Agregar',
                          style: TextStyle(color: Color(0xFFFFFFFF)),
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 64, 167, 195),
                          ),
                        ),
                        onPressed: () async {
                          final DateTimeRange? picked =
                              await showDateRangePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2027),
                              );
                          if (picked != null) {
                            setState(() {
                              _selectedDateRange = picked;
                            });
                          }
                        },
                        child: Text(
                          'Filtrar',
                          style: TextStyle(color: Color(0xFFFFFFFF)),
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 155, 159, 156),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _selectedDateRange = null;
                          });
                        },
                        child: Text(
                          'Mostrar todas',
                          style: TextStyle(color: Color(0xFFFFFFFF)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Cita>>(
                future: _citas,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No hay citas programadas.'));
                  }

                  final citas = _selectedDateRange == null
                      ? snapshot.data!
                      : snapshot.data!.where((cita) {
                          return cita.date.compareTo(
                                    _selectedDateRange!.start
                                        .toIso8601String()
                                        .split('T')[0],
                                  ) >=
                                  0 &&
                              cita.date.compareTo(
                                    _selectedDateRange!.end
                                        .toIso8601String()
                                        .split('T')[0],
                                  ) <=
                                  0;
                        }).toList();

                  return ListView.builder(
                    itemCount: citas.length,
                    itemBuilder: (context, index) {
                      final cita = citas[index];
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Text(cita.patientName),
                          subtitle: Text(cita.date),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Cita {
  final int id;
  final int doctorId;
  final String patientName;
  final String date;

  Cita({
    required this.id,
    required this.doctorId,
    required this.patientName,
    required this.date,
  });

  factory Cita.fromJson(Map<String, dynamic> json) {
    return Cita(
      id: json['id'],
      doctorId: json['doctorId'],
      patientName: json['patientName'],
      date: json['date'],
    );
  }
}
