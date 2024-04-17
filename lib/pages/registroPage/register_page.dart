import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/registroPage/data/datasource/registrar.dart';
import 'package:flutter_application_1/pages/registroPage/register_controller.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegisterController regCon = Get.put(RegisterController());
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController celularController = TextEditingController();
  final TextEditingController contrasenaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _ImageCover(),
          _Subtitulo('Regístrate', top: 170.0, left: 40.0, fontSize: 32.0, fontWeight: FontWeight.bold),
          _Subtitulo('aquí!', top: 220.0, left: 40.0, fontSize: 20.0, fontWeight: FontWeight.w400),
          _BtnParaRegresar(),
          _BoxFormulario(
            nombreController: nombreController,
            emailController: emailController,
            celularController: celularController,
            contrasenaController: contrasenaController,
            top: 330.0,
          ),
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
      right: 20.0,
      child: IconButton(
        icon: const Icon(Icons.arrow_circle_left_outlined, color: Colors.white, ),
        onPressed: () => Get.find<RegisterController>().goToHomePage(),
        iconSize: 40.0,
      ),
    );
  }
}

class _BoxFormulario extends StatelessWidget {
  final TextEditingController nombreController;
  final TextEditingController emailController;
  final TextEditingController celularController;
  final TextEditingController contrasenaController;
  final double top;

  const _BoxFormulario({
    required this.nombreController,
    required this.emailController,
    required this.celularController,
    required this.contrasenaController,
    this.top = 250.0,
  });

  @override
  Widget build(BuildContext context) {
    Color customColor = const Color(0xFF11245C);

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
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.markunread_outlined, color: customColor),
                  labelStyle: TextStyle(color: customColor),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customColor),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customColor),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: celularController,
                decoration: InputDecoration(
                  labelText: 'Celular',
                  prefixIcon: Icon(Icons.ad_units, color: customColor),
                  labelStyle: TextStyle(color: customColor),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customColor),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customColor),
                  ),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: contrasenaController,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  prefixIcon: Icon(Icons.https_outlined, color: customColor),
                  labelStyle: TextStyle(color: customColor),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customColor),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customColor),
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
  onPressed: () {
    register(
      context: context, // Pasa el contexto a la función register
      email: emailController.text,
      password: contrasenaController.text,
      phone_number: celularController.text,
    );
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: customColor, // Cambia el color del botón
  ),
  child: const Text(
    'Registrar',
    style: TextStyle(color: Colors.white), // Cambia el color del texto a blanco
  ),
),

            ],
          ),
        ),
      ),
    );
  }
}