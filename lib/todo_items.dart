import 'package:flutter/material.dart';
import 'todo.dart';

class ToDoItem extends StatelessWidget {

  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;

  const ToDoItem({Key?key,required this.todo,required this.onToDoChanged,required this.onDeleteItem}): super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onToDoChanged(todo);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: Colors.indigo[300],
        ),
        title: Text(
          todo.todoText!,
          style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              decoration: todo.isDone? TextDecoration.lineThrough:null,),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(vertical: 11),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(5)
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: const Icon(Icons.delete),
            onPressed: (){

              onDeleteItem(todo.id);
            },

          ),
        ),
      ),
    );
  }
}
