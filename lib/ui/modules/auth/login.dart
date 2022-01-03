import 'package:echat/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  Login({ Key? key }) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _authController = Get.find<AuthController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
            Text('Account Login', style: Theme.of(context).textTheme.headline4),
            const SizedBox(height: 20.0,), 
            Form(child: Column(children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'Email',

                  enabledBorder: OutlineInputBorder(), 
                  prefixIcon: Icon(Icons.email),
                ),
              ), 
              const SizedBox(height: 10.0,), 
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  hintText: 'Password',
                  enabledBorder: OutlineInputBorder(), 
                  prefixIcon: Icon(Icons.lock),
                ),
              ), 
              const SizedBox(height: 10.0,), 

              
              
              ElevatedButton(onPressed: ()async{
                await _authController.loginUser(emailController, passwordController);
              }, child: Text('Login', style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white),)), 
              const SizedBox(height: 10.0,), 

              const Text('OR'), 
              TextButton(child: Text('Create account', style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.blue),), onPressed: (){Get.toNamed('/signup');},)

            ],)) 

          ],
        ),
      )),
      
    );
  }
}