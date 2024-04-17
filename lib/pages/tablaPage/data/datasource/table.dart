import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SensorDataService {
  Future<Map<String, dynamic>> fetchLatestSensorData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceID = prefs.getString('deviceID') ??
        ''; // Obtener el dispositivo_id del almacenamiento local
    if (deviceID.isEmpty) {
      throw Exception(
          'Device ID not found in local storage'); // Manejar el caso en que no se encuentre ningún dispositivo_id en el almacenamiento local
    }
    final response = await http
        .get(Uri.parse('http://46.175.149.27:3006x/api/sensor/getLatest/$deviceID'));
    print("entre");
    if (response.statusCode == 200) {
      List<dynamic> sensorDataList = jsonDecode(response.body);
      if (sensorDataList.isNotEmpty) {
        return sensorDataList.first;
      } else {
        throw Exception('Empty sensor data list');
      }
    } else {
      throw Exception('Failed to load sensor data');
    }
  }
}
