import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void register({
  required BuildContext context,
  required String email,
  required String password,
  required String phone_number,
}) async {
  String apiUrl = 'http://46.175.149.27:3006/api/user/create';

  Map<String, String> datos = {
    'email': email,
    'password': password,
    'phone_number': phone_number,
  };

  try {
    http.Response respuesta = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode(datos),
      headers: {"Content-Type": "application/json"},
    );

    if (respuesta.statusCode == 200) {
      print('Los datos se enviaron correctamente a la API');
      print('Respuesta de la API: ${respuesta.body}');

      Navigator.pushNamed(context, '/');
    } else {
      print('Error al enviar los datos a la API');
      print('Código de estado: ${respuesta.statusCode}');

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color(0xFF4169E1), // Color de fondo agregado
            title: const Text('Error'),
            content: const Text('No se pudo registrar', textAlign: TextAlign.center,),
          );
        },
      );

      // Espera 2 segundos y luego cierra el cuadro de diálogo
      Future.delayed(Duration(seconds: 2), () {});
    }
  } catch (error) {
    print('Error: $error');
  }
}
