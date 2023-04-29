import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class Database {
  var myBox = Hive.box("todolist");

  List tasks = [];

  void addTask(Map<String, dynamic> task) {
    myBox.add(task);
    refresh();
  }

  void deleteTask(int id) {
    myBox.delete(id);
    refresh();
  }

  void updateTask(int id, Map<String, dynamic> task) {
    myBox.put(id, task);
    refresh();
  }

  void refresh() {
    var data = myBox.keys.map((key) {
      var task = myBox.get(key);
      return {"key" : key, "title": task["title"], "description" : task["description"], "isChecked" : task["isChecked"]};
    }).toList();

    tasks = data;
  }
}