
class UserModel {
  String id;
  String name;
  String email;

  UserModel({required this.id, required this.email, required this.name});
  
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email};
  }

  // factory UserModel.fromJson(DocumentSnapshot<Map<String, dynamic>?> json) {

  //   final id = json['id'] as String;
  //   final name = json['name'] as String;
  //   final email = json['email'] as String;

  //   return UserModel(id: id, email: email, name: name);
  // }

  // static UserModel fromMap(Map<String, dynamic> map) {
  //   return UserModel(
  //     id: map['id'],
  //     name: map['name'],
  //     email: map['email'],
  //   );
  // }

}
