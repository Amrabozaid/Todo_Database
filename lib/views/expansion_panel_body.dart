import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/add_small_todos_bottom_sheet.dart';
import '../controllers/expansion_panel_controller.dart';
import '../models/expansion_panels.dart';
import '../widgets/small_todo_widget.dart';

class ExpansionPanelBody extends StatefulWidget {
  
  const ExpansionPanelBody({super.key});

  @override
  State<ExpansionPanelBody> createState() => _ExpansionPanelBodyState();
}

class _ExpansionPanelBodyState extends State<ExpansionPanelBody> {


  ExpansionPanelController expansionPanelController = ExpansionPanelController() ;
  
   @override
  void initState() {
    super.initState();
    expansionPanelController.retrivePanels();
  }

  Widget completedTasksText(ExpansionPanels panel) {
  
    if (expansionPanelController.isCompletedLength(panel) == panel.smallTodos.length) {
      return const Text(
        "Completed",
        style: TextStyle(color: Colors.green),
      );
    } else if (expansionPanelController.isCompletedLength(panel) < panel.smallTodos.length &&
        expansionPanelController.isCompletedLength(panel) > 0) {
      return Text(
        "${expansionPanelController.isCompletedLength(panel)}/${panel.smallTodos.length} tasks Completed",
        style: const TextStyle(color: Colors.orange),
      );
    } else if (expansionPanelController.isCompletedLength(panel) == 0) {
      return Text(
        "0/${panel.smallTodos.length} task Completed",
        style: const TextStyle(color: Colors.grey),
      );
    }
    return const Text("No tasks");
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEE, dd, MMMM, yyyy').format(now);
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Today",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w700)),
              Container(
                margin: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(width: 2.0)
                ),
                child: Text("  $formattedDate  ", style: const TextStyle(fontSize:22,fontWeight: FontWeight.w700,color: Colors.grey))
              )
            ]
          ),
        ),
        toolbarHeight: 100.0,
      ),
      body: SizedBox(
        child: LayoutBuilder(builder: (BuildContext context,BoxConstraints constraints){
          return Column(
            children: [
              SizedBox(
                height: constraints.maxHeight *.85,
                child: SingleChildScrollView(
                  child:Padding(
                    padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth*.025,vertical: constraints.maxHeight *.025),
                    child: ExpansionPanelList(
                      materialGapSize: 20,
                      elevation: 0,
                      expansionCallback: (int index, bool isExpanded) {
                        setState(() {
                          expansionPanelController.allPanels[index].isExpanded = !expansionPanelController.allPanels[index].isExpanded;
                        });
                      },
                      children: expansionPanelController.allPanels.map<ExpansionPanel>((ExpansionPanels panel){
                        return ExpansionPanel(
                          backgroundColor: const Color.fromARGB(81, 132, 147, 164),
                          headerBuilder: (BuildContext context, bool isExpanded){
                            return SizedBox(
                              height: 60,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(panel.header, style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500)),
                                  completedTasksText(panel)
                                ],
                              ),
                            );
                          },
                          body: Column(
                            children: panel.smallTodos.map((smallTodo){
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: const Color.fromARGB(255, 85, 85, 85), width: 1.0),
                                        borderRadius: BorderRadius.circular(5.0)
                                      ),
                                      child: SmallTodoWidget(
                                        smallTodo: smallTodo,
                                        onDelete: (){setState(() {expansionPanelController.deleteSmallTodo(panel.header, smallTodo.id);});},
                                        onToggleCompleted: () { setState(() {expansionPanelController.toggleTodoCompletion(panel.header, smallTodo.id);});},
                                        onUpdate: (id, newTitle) {setState(() {expansionPanelController.updateSmallTodo(panel.header, id, newTitle);});}
                                      )
                                    ),
                                  ),
                                ],
                              );
                            }).toList()
                          ),isExpanded: panel.isExpanded
                        );
                      }).toList()
                    )
                  )
                )
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth*.025,vertical: constraints.maxHeight *.025),
                child: SizedBox(
                  width: constraints.maxWidth *.9,
                  height: constraints.maxHeight *.1,
                  child: ElevatedButton(
                    onPressed: (){
                      setState(() {
                        showModalBottomSheet(
                          context: context,
                          builder:(context) {
                            return AddSmallTodosBottomSheet(
                              onAdd: (panel) {
                                setState(() {
                                  if (expansionPanelController.allPanels.map((panel)=>panel.header).contains(panel.header)) {
                                    expansionPanelController.updatePanel(panel.header, panel.smallTodos.map((std)=>std.title).toSet());
                                  } else {
                                    expansionPanelController.addPanel(panel);
                                  }
                                });
                              }
                            );
                          }
                        );
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      shadowColor: Colors.grey,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0), side: const BorderSide(width: 3.0)),
                      backgroundColor: Colors.black
                    ),
                    child: const Text("+ Add task",style: TextStyle(fontSize: 24,color: Colors.white),)
                  ),
                ),
              ),
            ],
          );
        })
      ),
    );
  }
}