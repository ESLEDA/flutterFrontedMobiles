import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/pages/tablaPage/data/datasource/table.dart';
import 'package:flutter_application_1/pages/tablaPage/table_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/pages/tablaPage/data/datasource/updateTabla.dart';

class TablePage extends StatefulWidget {
  const TablePage({super.key});

  @override
  State<TablePage> createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  final TableController tabCon = Get.put(TableController());
  final SensorDataService sensorDataService = SensorDataService();
  final AlertConfigurationDispositive alertConfig =
      AlertConfigurationDispositive();
  Map<String, dynamic> sensorData = {};
  List<dynamic> confAlerts = [];

  @override
  void initState() {
    super.initState();
    _fetchSensorData();
    _fetchSensorDatas();
  }

  // Método para obtener los datos del sensor
  void _fetchSensorData() async {
    try {
      final data = await sensorDataService.fetchLatestSensorData();
      setState(() {
        sensorData = data;
      });
    } catch (e) {
      print('Error fetching sensor data: $e');
    }
  }

  void _fetchSensorDatas() async {
    try {
      List<Map<String, dynamic>> dataList =
          await alertConfig.getAlertConfigurationByDeviceId();

      // Actualizar el estado con los datos obtenidos
      setState(() {
        confAlerts = dataList;
      });

      // Iterar sobre la lista de objetos
      for (var alerta in dataList) {
        // Acceder a cada conf_alerta_id
        int confAlertId = alerta["conf_alerta_id"] as int;
        // Haz algo con el confAlertId, por ejemplo, imprimirlo
        print("conf_alerta_id: $confAlertId");
      }
    } catch (e) {
      print('Error fetching sensor data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _ImageCover(),
          _Subtitulo(
            top: 170.0,
            left: 40.0,
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
          ),
          _TitleTable(),
          _WhiteRectangleDateHour(),
          if (sensorData["fecha"] != null && sensorData["hora"] != null)
            _TableDateHour(
              fecha: sensorData['fecha']!,
              hora: sensorData['hora']!,
            ),
          _BtnParaRegresar(),
          _WhiteRectangle(),
          _TableData(sensorData: sensorData, confAlerts: confAlerts),
        ],
      ),
    );
  }
}

class _ImageCover extends StatelessWidget {
  const _ImageCover();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              child: Image.asset('assets/FondoSensores.jpg'),
            ),
          ],
        ),
      ),
    );
  }
}

class _Subtitulo extends StatefulWidget {
  final double top;
  final double left;
  final double fontSize;
  final FontWeight fontWeight;

  const _Subtitulo(
      {required this.top,
      required this.left,
      required this.fontSize,
      required this.fontWeight});

  @override
  _SubtituloState createState() => _SubtituloState();
}

class _SubtituloState extends State<_Subtitulo> {
  String deviceName = '';

  @override
  void initState() {
    super.initState();
    _loadDeviceName();
  }

  void _loadDeviceName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      deviceName = prefs.getString('deviceName') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.top,
      left: widget.left,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Estás dentro de:',
            style: TextStyle(
              color: const Color(0xFF11245C),
              fontSize: widget.fontSize,
              fontWeight: widget.fontWeight,
            ),
          ),
          Text(
            '$deviceName',
            style: TextStyle(
              color: const Color(0xFF11245C),
              fontSize: widget.fontSize,
              fontWeight: FontWeight.normal, // Puedes cambiar el estilo si es necesario
            ),
          ),
        ],
      ),
    );
  }
}


class _BtnParaRegresar extends StatelessWidget {
  const _BtnParaRegresar();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 45.0,
      //left: 20.0,
      right: 20.0,
      child: IconButton(
        icon: const Icon(
          Icons.arrow_circle_left_outlined,
          color: Color(0xFF11245C),
        ),
        onPressed: () => Navigator.pop(context), // Cambiado aquí
        iconSize: 40.0,
      ),
    );
  }
}

class _WhiteRectangle extends StatelessWidget {
  const _WhiteRectangle();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      top: 50,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width *
              0.78, // Ajusta el ancho del rectángulo según tus necesidades
          height: MediaQuery.of(context).size.height *
              0.102, // Ajusta la altura del rectángulo según tus necesidades
          decoration: BoxDecoration(
            color: Colors.white, // Establece el color blanco del rectángulo
            borderRadius: BorderRadius.circular(
                0.0), // Opcional: ajusta el radio de la esquina si deseas esquinas redondeadas
            border: Border.all(
                color: Colors.grey), // Opcional: agrega un borde al rectángulo
          ),
        ),
      ),
    );
  }
}

class _WhiteRectangleDateHour extends StatelessWidget {
  const _WhiteRectangleDateHour();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      top: 450,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width *
              0.78, // Ajusta el ancho del rectángulo según tus necesidades
          height: MediaQuery.of(context).size.height *
              0.070, // Ajusta la altura del rectángulo según tus necesidades
          decoration: BoxDecoration(
            color: Colors.white, // Establece el color blanco del rectángulo
            borderRadius: BorderRadius.circular(
                0.0), // Opcional: ajusta el radio de la esquina si deseas esquinas redondeadas
            border: Border.all(
                color: Colors.grey), // Opcional: agrega un borde al rectángulo
          ),
        ),
      ),
    );
  }
}

class _TableData extends StatelessWidget {
  final Map<String, dynamic> sensorData;
  final List<dynamic> confAlerts;

  const _TableData({
    Key? key,
    required this.sensorData,
    required this.confAlerts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int confAlertId1 = 0;
    int confAlertId2 = 0;
    int confAlertId3 = 0;

    // Verificar la longitud de confAlerts antes de acceder a sus elementos
    if (confAlerts.length >= 3) {
      confAlertId1 = confAlerts[0]["conf_alerta_id"] as int;
      confAlertId2 = confAlerts[1]["conf_alerta_id"] as int;
      confAlertId3 = confAlerts[2]["conf_alerta_id"] as int;
    }

    return Positioned.fill(
      top: 50,
      child: Center(
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: const {
            0: FractionColumnWidth(0.33),
            1: FractionColumnWidth(0.45),
            2: FractionColumnWidth(0.35),
          },
          border: TableBorder.all(),
          children: [
            _buildTableRow(
              context,
              'Temperatura',
              '${sensorData["temperatura"]} C°',
              () => _showNumberInputAlertDialog(
                context,
                '$confAlertId1',
              ),
            ),
            _buildTableRow(
              context,
              'Humedad',
              '${sensorData["humedad"]} %',
              () => _showNumberInputAlertDialog(context, '$confAlertId2'),
            ),
            _buildTableRow(
              context,
              'Voltaje',
              '${sensorData["voltaje"]} V',
              () => _showNumberInputAlertDialog(context, '$confAlertId3'),
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(
    BuildContext context,
    String label,
    String value,
    VoidCallback onTap,
  ) {
    return TableRow(
      children: [
        TableCell(
          child: GestureDetector(
            onTap: onTap,
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  color: Color(0xff11245C),
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ),
        TableCell(
          child: GestureDetector(
            onTap: onTap,
            child: Center(
              child: Text(
                value,
                style: TextStyle(
                  color: Color(0xff11245C),
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

void _showNumberInputAlertDialog(BuildContext context, String label) {
  TextEditingController _minController = TextEditingController();
  TextEditingController _maxController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Alerta'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Mínimo'),
            TextField(
              controller: _minController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "10",
                filled: true,
                fillColor: Colors.blue, // Cambiado a azul
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            SizedBox(height: 20),
            Text('Máximo'),
            TextField(
              controller: _maxController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "10",
                filled: true,
                fillColor: const Color.fromARGB(255, 111, 124, 134), // Cambiado a azul
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancelar'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: Text('Guardar'),
            onPressed: () {
              // Obtiene los valores mínimos y máximos ingresados
              int minValue = int.tryParse(_minController.text) ?? 0;
              int maxValue = int.tryParse(_maxController.text) ?? 0;

              var dsdasd = updateConfigAlert();
              // Llama al método para actualizar la configuración de alerta
              dsdasd.updateAlertConfiguration(label, minValue, maxValue);

              // Cierra el diálogo
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

class _TableDateHour extends StatelessWidget {
  final String fecha;
  final String hora;

  const _TableDateHour({required this.fecha, required this.hora});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      top: 450,
      child: Center(
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: const {
            0: FractionColumnWidth(0.33),
            1: FractionColumnWidth(0.45),
            2: FractionColumnWidth(0.35),
          },
          border: TableBorder.all(),
          children: [
            TableRow(
              children: [
                TableCell(
                  child: Center(
                    child: Text(
                      'Fecha',
                      style: TextStyle(
                        color: Color(0xff11245C),
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
                TableCell(
                  child: Center(
                    child: Text(
                      fecha,
                      style: TextStyle(
                        color: Color(0xff11245C),
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child: Center(
                    child: Text(
                      'Hora',
                      style: TextStyle(
                        color: Color(0xff11245C),
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
                TableCell(
                  child: Center(
                    child: Text(
                      hora,
                      style: TextStyle(
                        color: Color(0xff11245C),
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TitleTable extends StatelessWidget {
  final double top;

  // Agrega un constructor que tome el valor de 'top'
  const _TitleTable({this.top = 318.0}); // Valor por defecto de 318.0

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top, // Usa la variable 'top' aquí
      left: 40.0,
      right: 40.0,
      child: SizedBox(
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor:
                Color.fromARGB(255, 252, 252, 252), // Color de fondo
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  0.0), // Ajusta el radio de la esquina a 0 para hacer cuadrado
            ),
          ),
          child: const Text(
            'Datos mas recientes',
            style: TextStyle(
              color: Color.fromARGB(255, 17, 8, 8),
              fontSize: 18.0,
            ),
          ),
        ),
      ),
    );
  }
}

class _AddRoomButton extends StatelessWidget {
  const _AddRoomButton();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 650.0,
      left: 35.0,
      right: 35.0,
      child: SizedBox(
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF11245C), // Color de fondo
          ),
          child: const Text(
            'Añadir Aviso',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
