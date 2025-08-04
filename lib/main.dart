import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_2/providers/medico_providers.dart';
import 'autenticacion/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MedicoProvider(),
      child: MaterialApp(
        title: "MediConnect",
        home: PantallaLogin(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
