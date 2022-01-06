import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echat/models/message_model.dart';
import 'package:echat/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;
  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection('users');
  StreamController<List<UserModel>> userStream =
      StreamController<List<UserModel>>.broadcast();
  List<UserModel>? users;
  RxBool isLoading = false.obs;
  @override
  void onInit(){
    super.onInit();
    getAllUsers();
  }

    getAllUsers(){
    try{
      // String id = currentUserId;
    showLoading();
    var querySnapshots = _userCollectionRef.snapshots();
    print("QuerySnapshots $querySnapshots");
    // listen to firestore users in realtime
    querySnapshots.listen((QuerySnapshot snapshot){
      print(snapshot.docs);
       if(snapshot.docs.isNotEmpty){
         print('snapshot.docs is not empty');
      var userDocs = snapshot.docs
          .map((DocumentSnapshot document) =>
              UserModel.fromMap(document.data()! as Map<String, dynamic>))
              .where((element) => element.id != currentUserId)
          .toList();
          // adding users to stream
          userStream.add(userDocs);
          print('Users added to stream');
          users = userDocs;
          update();
          // hide loader
    }

    }
    );
    
    }
    on Exception catch(e){
      throw Exception(e);
    }
  }
  showLoading(){
    isLoading.toggle();
  }
  hideLoading(){
    isLoading.toggle();
  }
}