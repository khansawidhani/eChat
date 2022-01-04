import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echat/app/constants/constants.dart';
import 'package:echat/models/user_model.dart';
import 'package:echat/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  // FirebaseService? service;
  final _auth = FirebaseAuth.instance;
  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection('users');

  String currentUserId = Constants.prefs!.getString('uid').toString();
  RxList<UserModel>? users;
  RxBool isLoading = false.obs;
  @override
  void onInit(){
    super.onInit();
    // service = Get.put(FirebaseService());
    getAllUserOnce();
  }

    Future<List<UserModel>> getAllUserOnce() async {
    try{
      String id = _auth.currentUser!.uid;
    showLoading();
    var snapshots = await _userCollectionRef.get();
    hideLoading();
    if (snapshots.docs.isNotEmpty) {
      List<UserModel> usersList = snapshots.docs
          .map((user) => UserModel(
              id: user.get('id'),
              email: user.get('email'),
              name: user.get('name')))
          .where((user) => user.id != id)
          .toList();
          users = usersList.obs;
          return users!;
    }
    else{
      throw Exception();
    }
    }on Exception catch(e){
      print(e);
      throw Exception();
    }
  }
  showLoading(){
    isLoading.toggle();
  }
  hideLoading(){
    isLoading.toggle();
  }
}