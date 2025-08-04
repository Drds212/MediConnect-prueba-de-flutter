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