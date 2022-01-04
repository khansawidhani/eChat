import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echat/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final _auth = FirebaseAuth.instance;
  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection('users');

  Future<List<UserModel>> getAllUserOnce() async {
    try{
      String id = _auth.currentUser!.uid;
    
    var snapshots = await _userCollectionRef.get();
    if (snapshots.docs.isNotEmpty) {
      List<UserModel> usersList = snapshots.docs
          .map((user) => UserModel(
              id: user.get('id'),
              email: user.get('email'),
              name: user.get('name')))
          .where((user) => user.id != id)
          .toList();

          return usersList;
    }
    else{
      throw Exception();
    }
    }on Exception catch(e){
      print(e);
      throw Exception();
    }
  }
}
