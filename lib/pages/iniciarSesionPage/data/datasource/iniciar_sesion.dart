import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/sp32Page/sp32_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void inicio({
  required BuildContext context,
  required String email,
  required String password,
}) async {
  String apiUrl = 'http://46.175.149.27:3006/api/user/login';

  Map<String, String> datos = {
    'email': email,
    'password': password,
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

      Map<String, dynamic> userData = jsonDecode(respuesta.body);
      String userEmail = userData['data']
          ['email']; // Obtener el correo electrónico de la respuesta

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          'userId', userData['data']['usuario_id'].toString());
      await prefs.setString('email',
          userEmail); // Guardar el correo electrónico en el almacenamiento local

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Sp32Page()),
      );
    } else {
      print('Error al enviar los datos a la API');
      print('Código de estado: ${respuesta.statusCode}');

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color(0xFF4169E1), // Color de fondo agregado
            title: const Text('Error al iniciar sesión'),
            content:
                const Text('Datos incorrectos', textAlign: TextAlign.center),
            actions: <Widget>[],
          );
        },
      );

      // Esperar 2 segundos y luego cerrar el cuadro de diálogo
      Future.delayed(Duration(seconds: 2), () {});
    }
  } catch (error) {
    print('Error: $error');
  }
}
