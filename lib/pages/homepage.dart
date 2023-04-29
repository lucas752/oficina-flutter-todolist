import 'package:flutter/material.dart';
import 'package:todolist/model/database.dart';
import 'package:todolist/widgets/todocard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Database db = Database();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    db.refresh();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            showForm(context, null);
          },
          child: const Icon(
            Icons.add,
            color: Color.fromARGB(255, 28, 62, 77),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 28, 62, 77),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Center(
                child: Text(
                  "TO DO",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w800
                  ),
                ),
              ),
            ),
            db.tasks.isNotEmpty ? Expanded(
              child: ListView.builder(
                itemCount: db.tasks.length,
                itemBuilder: (context, index) {
                  return TodoCard(
                    onChanged: (p0) {
                      setState(() {
                        db.updateTask(db.tasks[index]["key"], {
                          "isChecked" : !db.tasks[index]["isChecked"],
                          "title" : db.tasks[index]["title"],
                          "description" : db.tasks[index]["description"],
                        }); 
                      });
                    },
                    isChecked: db.tasks[index]["isChecked"],
                    title: db.tasks[index]["title"], 
                    description: db.tasks[index]["description"], 
                    onPressedEdit: () {
                      showForm(context, db.tasks[index]);
                    }, 
                    onPressedDelete: () {
                      setState(() {
                        db.deleteTask(db.tasks[index]["key"]);
                      });
                    },
                  );
                },
              )
            ) : const Text(
              "Nenhuma tarefa cadastrada...",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w200
              ),
              )
          ],
        ),
      ),
    );
  }

  void showForm(BuildContext context, Map<String, dynamic>? task) {
    if (task != null) {
      titleController.text = task["title"];
      descriptionController.text = task["description"];
    } else {
      titleController.clear();
      descriptionController.clear();
    }

    showModalBottomSheet(
      isScrollControlled: true,
      context: context, 
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: "Título"
                ),
              ),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  hintText: "Descrição"
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromARGB(255, 28, 62, 77),
                  ),
                  width: 100,
                  height: 35,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        if (task != null) {
                          db.updateTask(task["key"], {
                            "isChecked" : task["isChecked"],
                            "title" : titleController.text,
                            "description" : descriptionController.text
                          });
                        } else {
                          db.addTask({
                          "isChecked" : false,
                          "title" : titleController.text,
                          "description" : descriptionController.text
                        });
                        }
                      });
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Salvar",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    )
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}