import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/sp32Page/sp32_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void esp32({
  required BuildContext context,
  required String nombre,
  required String descripcion,
}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userId = prefs.getString('userId');

  // Comprueba si userId es nulo
  if (userId == null) {
    throw Exception('User ID not found');
  }

  String apiUrl = 'http://46.175.149.27:3006/api/dispositivos/diposCreate';

  Map<String, String> datos = {
    'nombre': nombre,
    'descripcion': descripcion,
    'usuario_id': userId, // userId ya no es nulo aquí
  };

  try {
    http.Response respuesta = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode(datos),
      headers: {"Content-Type": "application/json"},
    );

if (respuesta.statusCode == 200) {
  print('Los datos se enviaron correctamente a la API');

  // Parsea la respuesta JSON
  Map<String, dynamic> respuestaJson = jsonDecode(respuesta.body);

  // Guarda el dispositivo_id
  int dispositivoId = respuestaJson['dispositivo_id'];  // Cambia 'String' a 'int'

  // Muestra el dispositivo_id en la consola
  print('Dispositivo ID: $dispositivoId');

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Sp32Page()),
      );

    } else {
        print('Error al enviar los datos a la API');
  print('Código de estado: ${respuesta.statusCode}');
  print('Respuesta del servidor: ${respuesta.body}');  // Imprime la respuesta completa del servidor
  // ...
      
      // Muestra un AlertDialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Los datos no se mandaron'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  } catch (error) {
    print('Error: $error');
  }
}