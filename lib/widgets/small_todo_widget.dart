import 'package:flutter/material.dart';
import '../models/small_todo.dart';


class SmallTodoWidget extends StatelessWidget {
  final SmallTodo smallTodo;
  final VoidCallback onDelete;
  final VoidCallback onToggleCompleted;
  final Function(String oldTitle, String smallTodo) onUpdate;

  const SmallTodoWidget({
    super.key,
    required this.smallTodo,
    required this.onDelete,
    required this.onToggleCompleted,
    required this.onUpdate
  });

  @override
  Widget build(BuildContext context) {
    return 
    SizedBox(
      child: LayoutBuilder(
        builder:(BuildContext context, BoxConstraints constraints){
          return Row(
            children: [
              SizedBox(
                width: constraints.maxWidth * .1,
                child: IconButton(
                  onPressed: onToggleCompleted,
                    icon: Icon(smallTodo.isCompleted
                        ? Icons.check_box
                        : Icons.check_box_outline_blank)
                        ,color: Colors.green,
                ),
              ),            
              SizedBox(
                width: constraints.maxWidth * .65,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    smallTodo.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      decoration: smallTodo.isCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                    )
                  )
                )
              ),
              SizedBox(
                width: constraints.maxWidth * .1,
                child: IconButton(
                      icon: Icon(
                        color: Colors.amber[500],
                        Icons.edit,
                      ),
                      onPressed: () {
                        _showEditTodoDialog(context, smallTodo);
                      }
                ),
              ),
              SizedBox(width: constraints.maxWidth * .1, child: IconButton(onPressed: onDelete, icon: const Icon(Icons.delete)))
            ],
          );
        } 
      )
    );

  }  
  void _showEditTodoDialog(BuildContext context, SmallTodo smallTodo) {
    String id = smallTodo.id;
    TextEditingController titleController = TextEditingController(text: smallTodo.title);
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text("Edit the small todo"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: const InputDecoration(labelText: "Title"),
                    controller: titleController,
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      onUpdate(id, titleController.text);
                      Navigator.pop(context);
                    },
                    child: const Text("Update"))
              ],
            ));
  }
}