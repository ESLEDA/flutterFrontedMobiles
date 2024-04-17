import 'package:get/get.dart';

class Sp32Controller extends GetxController{
  void goToInicioSesionPage(){
    Get.toNamed('/iniciarSesion');
  }

  void goToCuartoPage(){
    Get.toNamed('/cuarto');
  }

  void goToAddSp32Page(){
    Get.toNamed('/addSp32');
  }

  void goToPerfilPage(){
    Get.toNamed('/perfil');
  }

  fetchDispositivos() {}
}