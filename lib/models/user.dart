/*.........................................................................
 . Copyright (c)
 .
 . The user.dart class was created by : Alex Bolot and Pierre Bolot
 .
 . As part of the PhotoBooth project
 .
 . Last modified : 02/08/18 22:27
 .
 . Contact : contact.alexandre.bolot@gmail.com
 ........................................................................*/

class User {
  List<String> collections = [];
  String userName;

  String email;
  String password;

  User(this.userName, [this.collections, this.email, this.password]);

  User.fromMap(Map<String, dynamic> map)
      : collections = map['collections'],
        userName = map['userName'];

  Map<String, dynamic> toMap() {
    return {
      'collections': collections,
      'userName': userName,
    };
  }

  @override
  String toString() => 'User{userName: $userName}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          collections == other.collections &&
          userName == other.userName;

  @override
  int get hashCode => collections.hashCode ^ userName.hashCode;
}
