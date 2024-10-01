// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import './small_todo.dart';
// import './expansion_panels.dart';

// class SmallTodoAdapter extends TypeAdapter<SmallTodo>{

//   final int typeId = 0;

//   @override
//   SmallTodo read(BinaryReader reader) {
//     return SmallTodo(  
//       id: reader.readString(),
//       title: reader.readString(),
//       isCompleted: reader.readBool()
//     );
//   }
//   @override
//   void write(BinaryWriter writer, SmallTodo obj) {
//     writer.write(obj.id);
//     writer.write(obj.title);
//     writer.write(obj.isCompleted);
//   }


// }