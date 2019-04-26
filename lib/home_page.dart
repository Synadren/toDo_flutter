import 'dart:async';

import 'package:flutter/material.dart';
import 'package:to_do/fetch_data.dart';
import 'package:to_do/todo_page.dart';
import 'package:to_do/user_card.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'globals.dart' as globals;

class HomePage extends StatefulWidget {
  static String tag = 'home-page';
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  FetchData fetchUsers = FetchData('users', {});
  List<dynamic> usersList = [];

  AnimationController animationController;
  Animation<double> animation;

  void initState() {
    super.initState();
    getUsersList();

    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    )..addListener(() => setState(() {}));
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );

    animationController.forward();
  }

  void getUsersList() async {
    await fetchUsers.getData();

    setState(() {
      usersList = fetchUsers.data.sublist(0, 5);
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0, 1],
          colors: [
            globals.lightBlue,
            globals.darkBlue
          ],
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 100,
            ),
            Container(
              height: 100,
              child: FlareActor(
                "assets/anim.flr",
                alignment: Alignment.center,
                fit: BoxFit.contain,
                animation: "checkAnimation"
              )
            ),
            Container(
              padding: EdgeInsets.only(top: 0),
              child: Center(
                child: ScaleTransition(
                  scale: animation,
                  child: Text(
                    "Tout doux",
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Kristi',
                      fontSize: 70.0
                    )
                  ),
                )
              )
            ),
             Expanded(
              child:ListView.builder(
                padding: EdgeInsets.all(20),
                key: new Key(usersList.length.toString()),
                itemCount: usersList.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(ToDoPage.tag, arguments: usersList[index]['id']);
                    },
                    child: ScaleTransition(
                      scale: animation,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: UserCard(usersList[index])
                      )
                    )
                  );
                }
              )
             )
          ]
        )
      )
    );
  }
}