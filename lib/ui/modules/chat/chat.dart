import 'package:echat/app/constants/constants.dart';
import 'package:echat/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Chat extends StatelessWidget {
  Chat({ Key? key }) : super(key: key);
  final UserModel user = Get.arguments;  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
            Text(user.name), 
            Text(Constants.prefs!.getString('name').toString()), 
          ],
        ),
      ) ),
      
    );
  }
}