import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'pages/homaPage/home_page.dart';
import 'pages/registroPage/register_page.dart';
import 'pages/iniciarSesionPage/iniciar_sesion_page.dart';
import 'pages/sp32Page/sp32_page.dart';
import 'pages/tablaPage/tabla_page.dart';
import 'pages/addsp32Page/add_sp32_page.dart';
import 'pages/perfilPage/perfil_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState(){
    // Todo: implements initState
    super.initState();
  }
    
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Sensor',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () =>  HomePage()),
        GetPage(name: '/registro', page: () =>  const RegisterPage()),
        GetPage(name: '/iniciarSesion', page: () =>  const IniciarSesionPage()),
        GetPage(name: '/sp32', page: () =>  const Sp32Page()),
        GetPage(name: '/table', page: () =>  const TablePage()),
        GetPage(name: '/addSp32', page: () =>  const AddSp32Page()),
        GetPage(name: '/perfil', page: () => const PerfilPage()),
      ],
      navigatorKey: Get.key,

    );
  }

}
