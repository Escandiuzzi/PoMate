import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:poMate/Assets/styles.dart';
import 'package:poMate/Controller/appuser.dart';
import 'package:poMate/screens/analytics.dart';
import 'package:poMate/screens/ranking.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
bool logged = false;

UserCredential userCredentialR;

Future<String> signInWithGoogle() async {
  await Firebase.initializeApp();
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential authResult =
      await _auth.signInWithCredential(credential);
  userCredentialR = authResult;
  final User user = authResult.user;

  if (user != null) {
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    print('signInWithGoogle succeeded: $user');

    initializeUser();
    refreshAnalytics();

    SyncRanking(user);

    return '$user';
  }

  return null;
}

void SyncRanking(User _user) {
  users.clear();
  var db = FirebaseDatabase.instance.reference().child("Ranking");
  db.once().then((DataSnapshot snapshot) {
    Map<dynamic, dynamic> values = snapshot.value;

    updateValues(
        double.parse(values[_user.uid]["focusPoints"]),
        int.parse(values[_user.uid]["restCycles"]),
        int.parse(values[_user.uid]["focusCycles"]));

    values.forEach((key, values) {
      AppUser _dbUser = new AppUser(
          "0",
          values["name"].toString(),
          values["focusPoints"].toString(),
          values["email"].toString(),
          values["restCycles"].toString(),
          values["focusCycles"].toString());

      users.add(_dbUser);
      users.sort((b, a) =>
          double.parse(a.focusPoints).compareTo(double.parse(b.focusPoints)));
      refreshRanking();

      print(values["name"]);
      print(values["focusPoints"]);
      print(values["restCycles"]);
      print(values["focusCycles"]);
    });
  });
}

Future<void> signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Signed Out");
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlutterLogo(size: 150),
              SizedBox(height: 50),
              _signInButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        signInWithGoogle().then((result) {
          if (result != null) {
            setState(() {
              logged = true;
            });
          }
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
                image: AssetImage('lib/Assets/Images/google_logo.png'),
                height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                logged ? 'Signed' : 'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
