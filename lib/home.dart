import 'package:flutter/material.dart';
import 'package:to_do_app/todo_items.dart';
import 'package:to_do_app/todo.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList = ToDo.todoList();
  List<ToDo>_foundToDo =[];
  final _todoController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _foundToDo = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[100],
      appBar: buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                searchbox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 50),
                        child: const Text(
                          'All ToDos',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      for (ToDo todo in _foundToDo.reversed)
                        ToDoItem(todo: todo,
                        onToDoChanged: _handleToDoChange,
                        onDeleteItem:_deleteToDoItems,),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  margin: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 0),
                          blurRadius: 8.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: _todoController,
                    decoration: const InputDecoration(
                      hintText: 'Add a new ToDo item',
                      hintStyle: TextStyle(color: Colors.black),
                      border: InputBorder.none,
                    ),
                  ),
                )),
                Container(
                  margin: const EdgeInsets.only(bottom: 20, right: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      _addToDoItem(_todoController.text);

                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(55, 55),
                        backgroundColor: Colors.indigo,
                        elevation: 10),
                    child: const Text(
                      '+',
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItems(String id){
    setState(() {
    todoList.removeWhere((item) => item.id==id);

    });
  }

  void _addToDoItem(String todo){
    setState(() {
      todoList.add(ToDo(id: DateTime.now().millisecond.toString(), todoText: todo),);
    });

  }

  void _runFilter(String enteredKeyword){
    List<ToDo> results =[];
    if(enteredKeyword .isEmpty){
      results =todoList;
    }
    else{
      results =todoList.where((item)=>item.todoText!.
      toLowerCase().contains(enteredKeyword.toLowerCase()
      )).toList();
    }
    setState(() {
      _foundToDo =results;
    });
  }

  Container searchbox() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child:  TextField(
        onChanged: (value)=>_runFilter(value),
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(17),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.black),
            border: InputBorder.none),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      toolbarHeight: 70,
      elevation: 0,
      backgroundColor: Colors.indigo[100],
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu_sharp,
            color: Colors.black,
          ),
          CircleAvatar(
            backgroundImage: AssetImage('images/demoprofileimage.jpeg'),
            radius: 23,
          ),
        ],
      ),
    );
  }
}
