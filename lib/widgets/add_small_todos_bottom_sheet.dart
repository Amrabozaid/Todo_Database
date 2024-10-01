import 'package:flutter/material.dart';
import '../models/small_todo.dart';
import '../models/expansion_panels.dart';
import 'time_picker.dart';

class AddSmallTodosBottomSheet extends StatefulWidget {
  
  final Function(ExpansionPanels panel) onAdd;
  const AddSmallTodosBottomSheet({super.key, required this.onAdd});

  @override
  State<AddSmallTodosBottomSheet> createState() => AddSmallTodosBottomSheetState();
}

class AddSmallTodosBottomSheetState extends State<AddSmallTodosBottomSheet> {

  TimePicker timePicker=TimePicker();
  final TextEditingController _smallTodosTextController =TextEditingController();
  final Set<String>  texts = new Set<String>();
  
  Set<SmallTodo> convertToSmallTodoList(String panelTime, Set<String> titles) {
    return titles.map((title) => SmallTodo(panelTime: panelTime, title: title)).toSet();
  }

    void _addText() {
      if (_smallTodosTextController.text.isNotEmpty) {
        setState(() {
          texts.add(_smallTodosTextController.text);
          _smallTodosTextController.clear();
        });
      }
    }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width:47),
              const Text("Add task",style: TextStyle(fontSize: 24),),
              IconButton(onPressed:() {Navigator.pop(context);}, icon: const Icon(Icons.close))
            ]
          ),

          Row(
            children: [
              const Text("Time  ", style: TextStyle(fontSize: 18)),
              timePicker
            ],
          ),
      
          const SizedBox(height: 10),
              
          TextFormField(
            controller: _smallTodosTextController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              hintText: "Enter a todo description"
            ),
          ),
      
          const SizedBox(height: 10),
          
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: _addText, child: const Icon(Icons.add,color: Colors.black)
            )
          ),
          
          SizedBox(
            height: 80,
            child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: texts.map((text) => Container(
                margin: const EdgeInsets.symmetric(vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(15.0)
                ),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(text, style: const TextStyle(fontSize: 18)))).toList(),
              ),
            )
          ),
      
          SizedBox( 
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                if(texts.isNotEmpty){
                  ExpansionPanels panel = ExpansionPanels(
                    header: timePicker.timeString,
                    smallTodos: convertToSmallTodoList(timePicker.timeString, texts)
                  );
                widget.onAdd(panel);
                Navigator.pop(context);
                }else{
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        icon: const Icon(Icons.warning_rounded),
                        title: const Text("Tasks is empty!"),
                        content: const Text("You must add at least one task"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("OK")
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: const BorderSide(width: 3.0)    
                ),
                backgroundColor: Colors.black
              ),
              child: const Text("confirm",style: TextStyle(fontSize: 20,color: Colors.white))
            )
          )
        ],
      ),
    );
  }
}