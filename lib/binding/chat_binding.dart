import 'package:echat/controllers/chat_controller.dart';
import 'package:get/get.dart';

class ChatBinding extends Bindings{
  @override
  void dependencies() {
Get.put(ChatController()); 
  }

}