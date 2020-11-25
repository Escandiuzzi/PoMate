import 'package:firebase_database/firebase_database.dart';

class AppUser {
  String key;
  String uid;
  String name;
  String focusPoints;
  String email;

  AppUser(this.uid, this.name, this.focusPoints, this.email);

  AppUser.fromSnapshot(DataSnapshot snapshot)
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
