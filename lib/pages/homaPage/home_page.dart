// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/homaPage/home_controller.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final HomeController registerCon = Get.put(HomeController());
  //final HomeController iniciarSesionCon = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Image.asset('assets/FonfoHome.png'),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 55.0,
            left: MediaQuery.of(context).size.width * 0.73,
            child: const BtnRegistro(),
          ),
          Positioned(
            bottom: 80,
            right: MediaQuery.of(context).size.width * 0.48,
            child: const BtnIniciarSesion(),
          ),
        ],
      ),
    );
  }
}

class BtnRegistro extends StatelessWidget {
  const BtnRegistro({Key? key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextButton(
        style: TextButton.styleFrom(
          textStyle: const TextStyle(fontSize: 16.0),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          foregroundColor: const Color(0xFF11245C), // Color del texto actualizado aquí
        ),
        onPressed: () => Get.find<HomeController>().goToRegisterPage(),
        child: const Text('Regístrate'),
      ),
    );
  }
}

class BtnIniciarSesion extends StatelessWidget {
  const BtnIniciarSesion({Key? key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextButton(
        style: TextButton.styleFrom(
          textStyle: const TextStyle(fontSize: 20.0),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          foregroundColor: const Color(0xFF11245C), // Color del texto actualizado aquí
        ),
        onPressed: () => Get.find<HomeController>().goToIniciarSesionPge(),
        child: const Text('Iniciar sesión'),
      ),
    );
  }
}