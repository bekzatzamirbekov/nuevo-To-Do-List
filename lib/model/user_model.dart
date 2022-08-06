class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  String? item;
  UserModel({this.uid, this.email, this.firstName, this.secondName, this.item});

  //receive data from server

  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        firstName: map['firstName'],
        secondName: map['secondName'],
        item:map['item']);
  }

  //sending some data to our server

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      'item':item
    };
  }
}
