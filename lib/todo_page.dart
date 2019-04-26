import 'package:flutter/material.dart';
import 'package:to_do/fetch_data.dart';
import 'package:to_do/todo_card.dart';
import 'globals.dart' as globals;

class ToDoPage extends StatefulWidget {
  static String tag = 'todo-page';

  @override
  _ToDoPageState createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  TextEditingController addFieldController = TextEditingController();

  FetchData fetchTodos;
  List<dynamic> todoList = [];

  void initState() {
    super.initState();

    new Future.delayed(Duration.zero,() {
      var userId = ModalRoute.of(context).settings.arguments;
      fetchTodos = FetchData('todos?userId=${userId}', {});
      getTodoList();
    });
  }

  void getTodoList() async {
    await fetchTodos.getData();
    
    setState(() {
      todoList = fetchTodos.data;
    });
  }

  addTodo() {
    if(addFieldController.text.length > 0) {
      var newTodo = {
        "userId": 1, //TODO: dynamic user
        "title": addFieldController.text,
        "completed": false,
        "id": DateTime.now().millisecondsSinceEpoch
      };

      setState(() {
        this.todoList.insert(0, newTodo);
        this.addFieldController.text = '';
      });
    }
  }

  deleteTodo(id) {
    setState(() {
      this.todoList.removeWhere((item) => item['id'] == id);
    });
  }

  updateTodo(id, status) {
    setState(() {
      for (var todo in this.todoList) {
        if(todo['id'] == id) {
          todo['completed'] = status;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //print(ModalRoute.of(context).settings.arguments);
    
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            padding: new EdgeInsets.only(top: MediaQuery.of(context).padding.top-10),
            height: MediaQuery.of(context).padding.top + 55,
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
            child: Center(
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    )
                  ),
                  Container(
                    child:Center(
                      child: Text(
                        "Tout doux",
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Kristi',
                          fontSize: 50.0
                        )
                      )
                    )
                  )
                ]
              )
            )
          ),
          Expanded(
            child:ListView.builder(
              padding: EdgeInsets.all(20),
              key: new Key(todoList.length.toString()),
              itemCount: todoList.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return ToDoCard(todoList[index], deleteTodo, updateTodo);
              }
            ),
          ),
          Container(
            color: globals.lightGrey,
            padding: EdgeInsets.only(
              top: 20,
              bottom: 30,
              right: 30,
              left: 30
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: addFieldController,
                    onChanged: (v) => addFieldController.text = v,
                    decoration: new InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'New task',
                      hintStyle: TextStyle(color: globals.grey),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: globals.lightGrey, width: 0.0),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: globals.red, width: 2.0),
                        borderRadius: BorderRadius.circular(3)
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                FloatingActionButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  onPressed: () {
                    addTodo();
                  },
                  mini: true,
                  backgroundColor: globals.darkBlue,
                  child: Icon(
                    Icons.add,
                    size: 20.0,
                    color: Colors.white,
                  ),
                )
              ]
            )
          )
        ],
      )
    );
  }
}

/** TODO
-> Page accueil (lister des users et afficher leur liste au clic)
-> Supprimer une tache   ->  array.removeWhere((item) => item.id == todo['id'])
-> Animation
 */