import 'package:firebase_database/firebase_database.dart';

class User {
  String key;
  String uid;
  String name;
  String focusPoints;
  String email;

  User(this.uid, this.name, this.focusPoints, this.email);

  User.fromSnapshot(DataSnapshot snapshot)
      : key =  snapshot.value["uid"],
        name = snapshot.value["name"],
        focusPoints = snapshot.value["focusPoints"],
        email = snapshot.value["email"];

  toJson() {
    return {
      "email": email,
      "name": name,
      "focusPoints": focusPoints,
    };
  }
}
