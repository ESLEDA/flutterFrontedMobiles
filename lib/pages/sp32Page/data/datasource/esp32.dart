import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'; // Importa shared_preferences

class DeviceService {
  Future<List<dynamic>> fetchDevices() async {
    // Obtiene el ID del usuario del almacenamiento local
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');

    if (userId == null) {
      throw Exception('User ID not found');
    }

    final response = await http.get(Uri.parse('http://46.175.149.27:3006/api/dispositivos/listByUserId/$userId'));

    if (response.statusCode == 200) {
      List<dynamic> devices = jsonDecode(response.body);
      
      List<int> deviceIds = [];
      devices.forEach((device) {
        deviceIds.add(device['dispositivo_id']);
      });
      prefs.setStringList('deviceIds', deviceIds.map((id) => id.toString()).toList());
      
      return devices;
    } else {
      // Si la respuesta no es OK, lanzamos un error.
      throw Exception('Failed to load devices');
    }
  }
}
