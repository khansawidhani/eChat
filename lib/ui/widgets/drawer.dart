import 'package:echat/constants/constants.dart';
import 'package:echat/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';

class SidePanel extends StatelessWidget {
  SidePanel({
    Key? key,
  }) : super(key: key);
  final _authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ListView(
            children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.teal, 
            ),
            child: Center(
              child: Text(
                Constants.prefs!.getString('name').toString(),
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Colors.white),
              ),
            ),
            padding: const EdgeInsets.all(0),
          ),
        ListTile(
          leading: const Icon(Icons.group, color: Colors.black87,),
          title: Text('Friends', style: Theme.of(context).textTheme.subtitle1!.copyWith(fontWeight: FontWeight.bold, color: Colors.black87),),

        ),
        ListTile(
          leading: const Icon(Icons.settings, color: Colors.black87,),
          title: Text('Setting', style: Theme.of(context).textTheme.subtitle1!.copyWith(fontWeight: FontWeight.bold, color: Colors.black87),),

        ),


        
            ],
          ),
        ), 
        Row(
          
          children: [
          Expanded(
            child: Container(
              color: Colors.red.shade600,
              child: ElevatedButton(
                  onPressed: () {
                    _authController.logOutUser();
                  },
                  child: Text('Logout', style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white),),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.red.shade600),
                      elevation: MaterialStateProperty.all(0.0), 
                      
                      )),
            ),
          )
        ])
      ],
    ));
  }
}
