import 'package:get/get.dart';

class HomeController  extends GetxController{
  void goToRegisterPage(){
    Get.toNamed('/registro');
  }

  void goToIniciarSesionPge(){
    Get.toNamed('/iniciarSesion');
  }

}