/*.........................................................................
 . Copyright (c)
 .
 . The user.dart class was created by : Alex Bolot and Pierre Bolot
 .
 . As part of the PhotoBooth project
 .
 . Last modified : 03/08/18 01:53
 .
 . Contact : contact.alexandre.bolot@gmail.com
 ........................................................................*/

class User {
  List<String> collections;
  String userName;
  String email;
  String password;

  User(this.userName, {this.collections = const [], this.email, this.password});

  User.fromMap(Map<String, dynamic> map)
      : collections = map['collections'].cast<String>(),
        userName = map['userName'],
        email = map['email'];

  Map<String, dynamic> toMap() {
    return {
      'collections': collections,
      'userName': userName,
      'email': email,
    };
  }

  @override
  String toString() {
    return 'User{userName: $userName, email: $email, collections: $collections}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          collections == other.collections &&
          userName == other.userName &&
          email == other.email;

  @override
  int get hashCode => collections.hashCode ^ userName.hashCode ^ email.hashCode;
}