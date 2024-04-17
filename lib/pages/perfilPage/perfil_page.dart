import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/perfilPage/perfil_controller.dart';
import 'package:get/get.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final PerfilController perCon = Get.put(PerfilController());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          _ImageCover(),
          _Subtitulo('!Hola', top: 160.0, left: 40.0, fontSize: 32.0, fontWeight: FontWeight.bold),
          _Subtitulo('example@gamil.com', top: 200.0, left: 40.0, fontSize: 20.0, fontWeight: FontWeight.w400),
          _BtnParaRegresar(),
          _BoxFormulario(top: 400.0),
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
              child: Image.asset('assets/RegistroF2.jpg'),
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

  const _Subtitulo(this.texto, {required this.top, required this.left, required this.fontSize, required this.fontWeight});

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
              color: Colors.white,
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
      //left: 20.0,
      right: 20.0,
      
      child: IconButton(
        icon: const Icon(Icons.arrow_circle_left_outlined, color: Colors.white, ),
         onPressed: () => Get.find<PerfilController>().goToInicoPage(),
        iconSize: 40.0,
      ),
    );
  }
}


class _BoxFormulario extends StatelessWidget {
  final double top;

  const _BoxFormulario({this.top = 250.0}); // Valor predeterminado en caso de que no se proporcione

  @override
  Widget build(BuildContext context) {
    Color customColor = const Color(0xFF02075D); // Nuevo color #02075D

    return Positioned(
      top: top,
      left: 20.0,
      right: 20.0,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Email',
                style: TextStyle(color: customColor, fontSize: 18), // Tamaño y color cambiados
              ),
              const SizedBox(height: 10),
              Text(
                'example@gmail.com',
                style: TextStyle(color: customColor, fontSize: 18), // Tamaño y color cambiados
              ),
              const SizedBox(height: 30),
              
              Text(
                'Celular',
                style: TextStyle(color: customColor, fontSize: 18), // Tamaño y color cambiados
              ),
              const SizedBox(height: 10),
              Text(
                '55 1212 353',
                style: TextStyle(color: customColor, fontSize: 18), // Tamaño y color cambiados
              ),
              
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () => {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: customColor, // Se mantiene el color del botón
                ),
                child: const Text(
                  'Cerrar sesión',
                  style: TextStyle(color: Colors.white), // Se mantiene el color del texto a blanco
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}