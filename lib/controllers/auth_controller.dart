import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echat/app/constants/constants.dart';
import 'package:echat/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection('users');
      
  UserModel? _currentUser;
  UserModel get currentUser => _currentUser!;

  //////
  Future getUser(String uid) async {
    
  }

  /////////
  Future populateCurrentUser(User user) async {
    _currentUser = await getUser(user.uid);
  }
  ////////////// SIGNUP USER

  Future signupUserWithEmail(TextEditingController nameController,
      emailController, passwordController, confirmPasswordController) async {
    final name = nameController.text;
    final email = emailController.text;
    final password = passwordController.text;
    final cPassword = confirmPasswordController.text;

    if (password == cPassword) {
      // if password matched then, 
      try {
        // creating new user in auth
        UserCredential _userCredential = await _auth
            .createUserWithEmailAndPassword(email: email, password: password);
        _currentUser =
            UserModel(id: _userCredential.user!.uid, email: email, name: name);
            // adding user to firestore
        if (_currentUser != null) {
          try {
            await _userCollectionRef
                .doc(_currentUser!.id)
                .set(_currentUser!.toJson())
                .then((value) {
              print('User added');
              nameController.clear();
              emailController.clear();
              passwordController.clear();
              confirmPasswordController.clear();
            });
            Get.toNamed('/login');
          } 
          //firestore exception
          on Exception catch (e) {
            if (e is PlatformException) {
              return e.message;
            } else {
              print(e.toString());
            }
          }
        }
        return _userCredential.user != null;
      }

      // auth exception
      on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } 
    } 
    else {
      print('Passwords doesn\'t match');
    }
  }
  /////// LOGIN USER

  Future loginUser(TextEditingController emailController,
      TextEditingController passwordController) async {
    final email = emailController.text;
    final password = passwordController.text;

     try {
      UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      if(userCredential.user != null) {
        try {
       DocumentSnapshot userData = await _userCollectionRef.doc(userCredential.user!.uid).get();
      _currentUser = UserModel(id: userData.get('id'), email: userData.get('email'), name: userData.get('name'));
      Constants.prefs!.setString('uid' , userData.get('id'));
      Constants.prefs!.setString('name' , userData.get('name'));
      Constants.prefs!.setString('email' , userData.get('email'));
      Constants.prefs!.setBool('loggedin' , true);
       print(currentUser.name);


       Get.offNamed('/', arguments: currentUser);
    } on Exception catch (e) {
      print(e);
    }

      }

      return userCredential.user != null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }


  }

  Future logOutUser()async{
    await _auth.signOut();
    Constants.prefs!.remove('uid');
    Constants.prefs!.remove('name');
    Constants.prefs!.remove('email');
    Constants.prefs!.remove('loggedin');

    Get.offAllNamed("/login");

  }
}
