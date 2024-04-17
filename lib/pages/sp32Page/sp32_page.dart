import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/pages/addsp32Page/add_sp32_page.dart';
import 'package:flutter_application_1/pages/sp32Page/data/datasource/esp32.dart';
import 'package:flutter_application_1/pages/sp32Page/sp32_controller.dart';
import 'package:flutter_application_1/pages/tablaPage/tabla_page.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sp32Page extends StatefulWidget {
  const Sp32Page({Key? key}) : super(key: key);

  @override
  State<Sp32Page> createState() => _Sp32PageState();
}

class _Sp32PageState extends State<Sp32Page> {
  final DeviceService deviceService = DeviceService();

  List<Widget> tarjetas = [];

  @override
  void initState() {
    super.initState();
    _loadDevices();
  }

  void _loadDevices() async {
    List<dynamic> devices = await deviceService.fetchDevices();
    setState(() {
      tarjetas = _buildCards(devices);
    });
  }

List<Widget> _buildCards(List<dynamic> devices) {
  List<Widget> cards = [];

  for (int i = 0; i < devices.length; i++) {
    Map<String, dynamic> device = devices[i];
    cards.add(
      Container(
        width: 100,
        height: 70,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shadowColor: Colors.blue,
              textStyle: const TextStyle(fontSize: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setString('deviceID', device['dispositivo_id'].toString());
              await prefs.setString('deviceName', device['nombre']);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TablePage(),
                ),
              );
            },
            child: Container(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Dispositivo: ${device['dispositivo_id']}'),
                        Text(
                          'Nombre: ${device['nombre']}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Descripción: ${device['descripcion']}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Spacer(), // Agregado Spacer
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  return cards;
}

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _ImageCover(),
          const _Subtitulo('Inicio',
              top: 170.0,
              left: 40.0,
              fontSize: 32.0,
              fontWeight: FontWeight.bold),
          const _Subtitulo('Visualización de los Sp32',
              top: 220.0,
              left: 40.0,
              fontSize: 20.0,
              fontWeight: FontWeight.w400),
          const _BtnParaRegresar(),
          Positioned(
            top: 300.0, // Ajusta este valor según tus necesidades
            height: 4000.0, // Ajusta este valor según tus necesidades
            left: 0,
            right: 0,
            child: ListView.builder(
              itemCount: tarjetas.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      bottom:
                          10.0), // Ajusta este valor para cambiar la separación entre tarjetas
                  child: tarjetas[index],
                );
              },
            ),
          ),
          const _AddRoomButton(),
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

class _Subtitulo extends StatelessWidget {
  final String texto;
  final double top;
  final double left;
  final double fontSize;
  final FontWeight fontWeight;

  const _Subtitulo(this.texto,
      {required this.top,
      required this.left,
      required this.fontSize,
      required this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            texto,
            style: TextStyle(
              color: const Color(0xFF11245C),
              fontSize: fontSize,
              fontWeight: fontWeight,
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
      right: 20.0,
      child: Center(
        child: IconButton(
          icon: const Icon(Icons.account_circle, color: Color(0xFF11245C)),
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            String userEmail = prefs.getString('email') ??
                ''; // Obtener el correo electrónico guardado
            _showLogoutDialog(context,
                userEmail); // Pasar el correo electrónico al método _showLogoutDialog
          },
          iconSize: 40.0,
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, String userEmail) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blue, // Color de fondo del cuadro de diálogo
          title: const Text('¡HOLA!',
              style: TextStyle(color: Colors.white)), // Color del título
          content: Text(userEmail,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.center), // Color del contenido
          actions: <Widget>[
            Container(
              // Contenedor para centrar el botón
              alignment: Alignment.center,
              child: TextButton(
                child: const Text('Cerrar Sesión'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFF11245C), // Color del texto
                ),
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _AddRoomButton extends StatelessWidget {
  const _AddRoomButton();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 700.0, // Cambia este valor para mover el botón más abajo
      left: 35.0,
      right: 35.0,
      child: SizedBox(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddSp32Page()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF11245C), // Color de fondo
          ),
          child: const Text(
            'Añadir dispositivo',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
