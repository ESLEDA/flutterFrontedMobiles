import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/iniciarSesionPage/data/datasource/iniciar_sesion.dart';
import 'package:flutter_application_1/pages/iniciarSesionPage/iniciar_sesion_controller.dart';
import 'package:get/get.dart';

class IniciarSesionPage extends StatefulWidget {
  const IniciarSesionPage({Key? key}) : super(key: key);

  @override
  State<IniciarSesionPage> createState() => _IniciarSesionPageState();
}

class _IniciarSesionPageState extends State<IniciarSesionPage> {
  final IniciarSesionController iniciarSesionController = Get.put(IniciarSesionController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _ImageCover(),
          _Subtitulo('Bienvenido!', top: 170.0, left: 40.0, fontSize: 32.0, fontWeight: FontWeight.bold),
          _Subtitulo('Inicia sesión', top: 220.0, left: 40.0, fontSize: 20.0, fontWeight: FontWeight.w400),
          _BtnParaRegresar(),
          _BoxFormulario(top: 400.0, emailController: emailController, passwordController: passwordController), // Pasar los controladores al widget _BoxFormulario
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
        onPressed: () => Get.find<IniciarSesionController>().goToHomePage(),
        iconSize: 40.0,
      ),
    );
  }
}

class _BoxFormulario extends StatelessWidget {
  final double top;
  final TextEditingController emailController; // Definir emailController fuera del constructor
  final TextEditingController passwordController; // Definir passwordController fuera del constructor

  const _BoxFormulario({required this.top, required this.emailController, required this.passwordController}); // Pasar emailController y passwordController como parámetros

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
              const SizedBox(height: 20),
              TextField(
                controller: emailController, // Usar emailController pasado como parámetro
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
                controller: passwordController, // Usar passwordController pasado como parámetro
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
                  String email = emailController.text;
                  String password = passwordController.text;
                  
                  print('Email: $email, Contraseña: $password');
                  inicio(context: context, email: email, password: password); 
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: customColor, // Cambia el color del botón
                ),
                child: const Text(
                  'Iniciar sesión',
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