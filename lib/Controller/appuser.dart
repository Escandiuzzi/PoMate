import 'package:firebase_database/firebase_database.dart';

class AppUser {
  String key;
  String uid;
  String name;
  String focusPoints;
  String email;
  String restCycles;
  String focusCycles;

  AppUser(this.uid, this.name, this.focusPoints, this.email, this.restCycles,
      this.focusCycles);

  AppUser.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.value["uid"],
        name = snapshot.value["name"],
        focusPoints = snapshot.value["focusPoints"],
        email = snapshot.value["email"],
        restCycles = snapshot.value["restCycles"],
        focusCycles = snapshot.value["focusCycles"];

  toJson() {
    return {
      "email": email,
      "name": name,
      "focusPoints": focusPoints,
      "restCycles": restCycles,
      "focusCycles": focusCycles,
    };
  }
}
