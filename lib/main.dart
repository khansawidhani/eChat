import 'package:echat/binding/binding.dart';
import 'package:echat/ui/modules/auth/login.dart';
import 'package:echat/ui/modules/auth/signup.dart';
import 'package:echat/ui/modules/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Binding().dependencies();
  runApp(const Echat());
}
class Echat extends StatelessWidget {
  const Echat({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(
        textTheme: GoogleFonts.robotoSlabTextTheme().copyWith(
          headline4: const TextStyle(color: Colors.black87)
          
        )
      ),
      title: 'eChat-app',
      initialRoute: '/login',
      getPages: [
        
        GetPage(name: '/', page: ()=> Home()), 
        GetPage(name: '/signup', page: ()=> SignUp()), 
        GetPage(name: '/login', page: ()=> Login()), 




      ],
      
    );
  }
}