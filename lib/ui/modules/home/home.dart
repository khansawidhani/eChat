import 'package:echat/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  Home({ Key? key }) : super(key: key);
  UserModel currentUser = Get.arguments; 
  @override
  Widget build(BuildContext context) {
    print(currentUser.email);
    return Scaffold(
      appBar: AppBar(), 
      body: const Center(child: Text('Hello App'),),
    );
  }
}