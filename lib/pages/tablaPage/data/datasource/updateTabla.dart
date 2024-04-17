import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class updateConfigAlert {
  Future<void> updateAlertConfiguration(
      String sensorId, int minValue, int maxValue) async {
    var headers = {'Content-Type': 'application/json'};
    var body = json.encode({"rango_max": maxValue, "rango_min": minValue});
    var response = await http.put(
        Uri.parse('http://46.175.149.27:3006/api/confAlertas/updateById/$sensorId'),
        headers: headers,
        body: body);

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.reasonPhrase);
    }
  }
}

class AlertConfigurationDispositive {
  Future<List<Map<String, dynamic>>> getAlertConfigurationByDeviceId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceID = prefs.getString('deviceID') ?? ''; // Obtener el dispositivo_id del almacenamiento local
    if (deviceID.isEmpty) {
      throw Exception('Device ID not found in local storage'); // Manejar el caso en que no se encuentre ningún dispositivo_id en el almacenamiento local
    }
    var request = http.Request('GET',Uri.parse('http://46.175.149.27:3006/api/confAlertas/getByDispId/$deviceID'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonResponse = await response.stream.bytesToString();
      // Parsea la respuesta JSON a una lista de mapas
      List<dynamic> dataList = jsonDecode(jsonResponse);
      return dataList.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
