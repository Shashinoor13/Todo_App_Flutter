import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List Tasks = [];
  //reference the box
  final _myBox = Hive.openBox('myBox');
}
