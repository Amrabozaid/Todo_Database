import 'small_todo.dart';

class ExpansionPanels {
  String header;
  Set<SmallTodo> smallTodos;
  bool isExpanded;


  ExpansionPanels({
    required this.header,
    required this.smallTodos,
    this.isExpanded=false
  });

  Map <String, dynamic> expansionPanelToDataBase() {return {
    'header': header,
    'smallTodos': smallTodos
  };}

  factory ExpansionPanels.expansionPanelFromDataBase(Map<String, dynamic> map){
    return ExpansionPanels(
      header: map['header'],
      smallTodos: map['smallTodos']
    );
  }

}