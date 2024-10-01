// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'small_todo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SmallTodoAdapter extends TypeAdapter<SmallTodo> {
  @override
  final int typeId = 0;

  @override
  SmallTodo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SmallTodo(
      title: fields[1] as String,
      panelTime: fields[3] as String,
      isCompleted: fields[2] as bool,
    )..id = fields[0] as String;
  }

  @override
  void write(BinaryWriter writer, SmallTodo obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.isCompleted)
      ..writeByte(3)
      ..write(obj.panelTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SmallTodoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
