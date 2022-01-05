import 'package:echat/controllers/auth_controller.dart';
import 'package:get/get.dart';

class Binding extends Bindings{
  @override
  void dependencies() {
    Get.put(AuthController());
    
  }

}