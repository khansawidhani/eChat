import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echat/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;
  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection('users');
  RxList<UserModel>? users;
  RxBool isLoading = false.obs;
  @override
  void onInit(){
    super.onInit();
    getAllUserOnce();
  }

    Future<List<UserModel>> getAllUserOnce() async {
    try{
      String id = currentUserId;
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