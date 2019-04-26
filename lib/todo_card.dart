import 'package:flutter/material.dart';
import 'globals.dart' as globals;

class ToDoCard extends StatefulWidget {
  final Object todo;
  final Function deleteTodo;
  final Function updateTodo;

  ToDoCard(this.todo, this.deleteTodo, this.updateTodo);

  @override
  _ToDoCardState createState() => _ToDoCardState(todo, deleteTodo, updateTodo);
}

class _ToDoCardState extends State<ToDoCard> {
  Map todo;
  Function deleteTodo;
  Function updateTodo;

  _ToDoCardState(this.todo, this.deleteTodo, this.updateTodo);

  @override
  Widget build(BuildContext context) {

    var checkIconColor = todo['completed'] ? globals.green : Colors.white;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () {
              updateTodo(todo['id'], !todo['completed']);
            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: new BoxDecoration(
                border: new Border.all(
                  color: todo['completed'] ? globals.green : globals.grey,
                  width: 2.0
                ),
                borderRadius: new BorderRadius.circular(50),
              ),
              child: Icon(
                  Icons.check,
                  size: 18.0,
                  color: checkIconColor,
                ),
            )
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                todo['title'],
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
                style: new TextStyle(
                  color: todo['completed'] ? globals.darkGrey : globals.black,
                  decoration: todo['completed'] ? TextDecoration.lineThrough : TextDecoration.none,
                  fontSize: 16.0,
                ),
              )
            )
          ),
          IconButton(
            icon: Icon(Icons.delete_outline),
            color: globals.red,
            onPressed: () {
              deleteTodo(todo['id']);
            },
          )
        ]
      )
    );
  }
}
