import 'package:flutter/material.dart';
import 'package:poMate/Assets/styles.dart';
import 'package:poMate/Controller/appuser.dart';

List<AppUser> users = new List();

class RankingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Ranking(),
    );
  }
}

class Ranking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      SizedBox(
        height: 40,
      ),
      Center(
        child: Text(
          'Ranking',
          style: optionStyle,
        ),
      ),
      SizedBox(
        height: 20,
      ),
      RankingList(),
    ]);
  }
}

class RankingList extends StatefulWidget {
  @override
  _RankingListState createState() => _RankingListState();
}

void refreshRanking() {
  setState() {}
}

class _RankingListState extends State<RankingList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: users.length,
      itemBuilder: (context, index) {
        final _user = users[index];
        return UserCard(_user);
      },
    );
  }
}

class UserCard extends StatelessWidget {
  final AppUser _appUser;

  UserCard(this._appUser);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          _appUser.name,
          style: cardStyle,
        ),
        subtitle: Text(
          _appUser.focusPoints,
          style: cardSubStyle,
        ),
      ),
      margin: EdgeInsets.all(10),
    );
  }
}
