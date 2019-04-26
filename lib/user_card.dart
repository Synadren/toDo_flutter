import 'package:flutter/material.dart';
import 'globals.dart' as globals;

class UserCard extends StatefulWidget {
  final Map user;

  UserCard(this.user);

  @override
  _UserCardState createState() => _UserCardState(user);
}

class _UserCardState extends State<UserCard> {
  Map user;

  _UserCardState(this.user);

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    user['name'],
                    style: 
                    TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    )
                  ),
                  Text(
                    user['email'],
                    style: TextStyle(
                      color: globals.darkBlue,
                      fontSize: 15
                    )
                  )
                ]
              )
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 18.0,
              color: globals.grey,
            )
          ],
        )
      )
    );
  }
}