import 'package:flutter/material.dart';
import 'package:prueba_2/medicos/perfil_medicos.dart';
import 'package:prueba_2/pacientes/pantalla_pacientes.dart';

class ListaMedicos extends StatelessWidget {
  final List<Medico> medicos;

  const ListaMedicos({Key? key, required this.medicos}) : super(key: key);

@override
Widget build(BuildContext context) {
  return ListView.builder(
    itemCount: medicos.length,
    itemBuilder: (context, index) {
      final medico = medicos[index];
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
          child: ListTile(
            title: Text(medico.name),
            subtitle: Text(medico.specialty ?? 'Sin especialidad'),
            trailing: Text(medico.rating != null ? medico.rating!.toString() : 'N/A'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PerfilMedico(medico: medico),
                ),
              );
            },
          ),
        ),
      );
    },
  );
}

}