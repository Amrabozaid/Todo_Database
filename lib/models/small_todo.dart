import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'small_todo.g.dart';
@HiveType(typeId: 0)
class SmallTodo{
  @HiveField(0)
  String id;
  
  @HiveField(1)
  String title;
  
  @HiveField(2)
  bool isCompleted;

  @HiveField(3)
  String panelTime;

  SmallTodo({
      required this.title,
      required this.panelTime,
      this.isCompleted = false
    }): id = Uuid().v4();

  void addTodo(SmallTodo smallTodo) async {
    var box = Hive.box('smallTodosBox');
    await box.put(smallTodo.id, smallTodo);
  }

  List<SmallTodo> getSmallTodos() {
    var box = Hive.box('smallTodosBox');
    return box.values.toList().cast<SmallTodo>();
  }

  void toggleSmallTodoCheck(String id) async {
    var box = Hive.box('smallTodosBox');
    SmallTodo smallTodo = box.get(id);
    smallTodo.isCompleted = !smallTodo.isCompleted;
    await box.put(id, smallTodo);
  }

  // Map <String, dynamic> smallTodoToDataBase() {return {
  //   'id': id,
  //   'title': title,
  //   'isCompleted': isCompleted
  // };}

  // factory SmallTodo.smallTodofromDataBase(Map<String, dynamic> map){
  //   return SmallTodo(
  //     id: map['id'],
  //     title: map['title'],
  //     isCompleted: map['isCompleted']
  //   );
  // }


}