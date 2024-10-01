import 'package:hive/hive.dart';

import '../models/expansion_panels.dart';
import '../models/small_todo.dart';

class ExpansionPanelController {
  final Box<SmallTodo> _smallTodoBox = Hive.box<SmallTodo>('smallTodosBox');
  List<ExpansionPanels> allPanels = [];

  Future<void> addPanel(ExpansionPanels panel) async {
    allPanels.add(panel);
    for (var addedSTD in panel.smallTodos) {
        await _smallTodoBox.put(addedSTD.id, addedSTD);
      }
  }

  void retrivePanels(){
    List<ExpansionPanels> retrievedPanels = [];
    var allSmallTodos=_smallTodoBox.values.toList();
    for(var smallTodo in allSmallTodos){
      if(allPanels.map((p)=>p.header).contains(smallTodo.panelTime)){
        int index = allPanels.indexWhere((p) => p.header == smallTodo.panelTime);
        ExpansionPanels currentPanel = allPanels[index];
        currentPanel.smallTodos.add(smallTodo);
      }
      else{
        List<SmallTodo> newPanelSTDs = [];
        newPanelSTDs.add(smallTodo);
        ExpansionPanels newPanel = ExpansionPanels(header: smallTodo.panelTime, smallTodos: newPanelSTDs.toSet());
        allPanels.add(newPanel);
      }
    }
  }

  Future<void> updatePanel(String header, Set<String> newSmallTodos) async {
    int index = allPanels.indexWhere((p) => p.header == header);
    ExpansionPanels currentPanel = allPanels[index];
    if (index != -1) {
      for (var newSTD in newSmallTodos) {
        if(!currentPanel.smallTodos.map((std)=>std.title).contains(newSTD)){
          currentPanel.smallTodos.add(
            new SmallTodo(
              panelTime: currentPanel.header, 
              title: newSTD
            )
          );
        }
      }
      for (var addedSTD in currentPanel.smallTodos) {
        await _smallTodoBox.put(addedSTD.id, addedSTD);
      }
    }
  }

  Future<void> deleteSmallTodo(String header, String smallTodoId) async {
    int index = allPanels.indexWhere((p) => p.header == header);
    ExpansionPanels currentPanel = allPanels[index];
    if (index != -1) {
      currentPanel.smallTodos.removeWhere((std)=>std.id == smallTodoId);
      await _smallTodoBox.delete(smallTodoId);
    }
    if(currentPanel.smallTodos.length==0){
      allPanels.removeAt(index);
    }
  }

  Future<void> toggleTodoCompletion(String header, String smallTodoId) async {
    int index = allPanels.indexWhere((p) => p.header == header);
    if (index != -1) {
      SmallTodo smallTodo = allPanels[index].smallTodos.where((std)=>std.id == smallTodoId).first;
      smallTodo.isCompleted = !smallTodo.isCompleted;
      
      var retrievedSmallTodo = _smallTodoBox.get(smallTodoId);
      if(retrievedSmallTodo!=null){
        retrievedSmallTodo.isCompleted=smallTodo.isCompleted;
        await retrievedSmallTodo.save();
      }
    }
  }

  int isCompletedLength(ExpansionPanels panel){
    return panel.smallTodos.where((s) => s.isCompleted).length;
  }

  Future<void> updateSmallTodo(String header, String smallTodoId, String newTitle) async {
    int panelIndex = allPanels.indexWhere((p) => p.header == header);
    if (panelIndex != -1) {
      ExpansionPanels currentPanel = allPanels[panelIndex];
      if(!currentPanel.smallTodos.map((std)=>std.title).contains(newTitle)){
        SmallTodo smallTodo = currentPanel.smallTodos.where((std)=>std.id == smallTodoId).first;
        smallTodo.title = newTitle;
        
        var retrievedSmallTodo = _smallTodoBox.get(smallTodoId);
        if(retrievedSmallTodo!=null){
          retrievedSmallTodo.title=newTitle;
          await retrievedSmallTodo.save();
        }
      }
    }
  }
}