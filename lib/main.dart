import 'package:echat/binding/binding.dart';
import 'package:echat/constants/constants.dart';
import 'package:echat/ui/modules/auth/login.dart';
import 'package:echat/ui/modules/auth/signup.dart';
import 'package:echat/ui/modules/chat/chat.dart';
import 'package:echat/ui/modules/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  InitBinding().dependencies();
  Constants.prefs = await SharedPreferences.getInstance();
  runApp(const Echat());
}

class Echat extends StatelessWidget {
  const Echat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isUser = Constants.prefs!.getBool('loggedin') ?? false;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: GoogleFonts.robotoSlabTextTheme()
              .copyWith(headline4: const TextStyle(color: Colors.black87))),
      title: 'eChat',
      initialRoute: isUser ? '/' : '/login',
      getPages: [
        GetPage(name: '/', page: () => Home(), binding: HomeBinding()),
        GetPage(name: '/signup', page: () => SignUp()),
        GetPage(name: '/login', page: () => Login()),
        GetPage(name: '/chat', page: () => Chat(), binding: ChatBinding()),
      ],
    );
  }
}
