
class UserModel {
  String id;
  String name;
  String email;

  UserModel({required this.id, required this.email, required this.name});
  
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email};
  }

  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(

      id: map['id'],
      name: map['name'],
      email: map['email'],
      
    );
  }

}
