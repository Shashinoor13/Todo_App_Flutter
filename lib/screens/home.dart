// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/database.dart';
import '../constant/colors.dart';
import '../model/todo.dart';
import '../widgets/todo_item.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //reference the box
  final _myBox = Hive.openBox('myBox');

  final todosList = ToDo.todoList();
  final _todoController = TextEditingController();
  ToDoDatabase db = ToDoDatabase();
  List<ToDo> _foundToDo = [];

  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGcolor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 30, bottom: 15),
                        // ignore: prefer_const_constructors
                        child: Text(
                          'To-Do',
                          // ignore: prefer_const_constructors
                          style: TextStyle(
                            color: tdBlack,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      for (ToDo todo in _foundToDo)
                        ToDoItem(
                          todo: todo,
                          onToDoChanged: _handleTodoChange,
                          onDeleteItem: _deleteTodoItem,
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(
                child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 30,
                      right: 20,
                      left: 20,
                    ),
                    decoration: BoxDecoration(
                      // ignore: prefer_const_literals_to_create_immutables
                      boxShadow: [
                        // ignore: prefer_const_constructors
                        BoxShadow(
                          color: tdGrey,
                          offset: const Offset(2.0, 1.0),
                          blurRadius: 3,
                        ),
                      ],
                      color: tdWhite,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Add a new task',
                        hintStyle: TextStyle(
                          color: tdGrey,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                      ),
                    )),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 30, right: 20),
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: tdGrey,
                      offset: Offset(2.0, 1.0),
                      blurRadius: 1,
                    )
                  ],
                  color: tdBlue,
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.add,
                    color: tdWhite,
                  ),
                  onPressed: () {
                    _addTodoItem(_todoController.text);
                    _todoController.clear();
                  },
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: tdWhite,
        borderRadius: BorderRadius.circular(20),
      ),
      // ignore: prefer_const_constructors
      child: TextField(
        onChanged: (value) => _runFilterr(value),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Search',
          prefixIcon: Icon(Icons.search, color: tdBlack),
          prefixIconConstraints: BoxConstraints(maxHeight: 25, minHeight: 20),
        ),
      ),
    );
  }

  void _handleTodoChange(ToDo todo) {
    setState(() {});
    todo.isDone = !todo.isDone;
  }

  void _deleteTodoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _addTodoItem(String toDo) {
    setState(() {
      // ignore: prefer_conditional_assignment
      if (toDo.isEmpty) {
        toDo = 'Null';
      }
      todosList.add(ToDo(
        id: DateTime.now().toString(),
        todoText: toDo,
        isDone: false,
      ));
    });
  }

  void _runFilterr(String enteredKeyWord) {
    List<ToDo> results = [];
    if (enteredKeyWord.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where(
            (todo) => todo.todoText!
                .toLowerCase()
                .contains(enteredKeyWord.toLowerCase()),
          )
          .toList();
    }

    setState(
      () {
        _foundToDo = results;
      },
    );
  }

//App Bar Starts Here
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGcolor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.menu, color: tdBlack, size: 30),
          // ignore: sized_box_for_whitespace
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset('assets/images/avatar.jpeg'),
            ),
          ),
        ],
      ),
    );
  }
}
