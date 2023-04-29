import 'package:flutter/material.dart';

class TodoCard extends StatefulWidget {
  String title;
  String description;
  Function()? onPressedEdit;
  Function()? onPressedDelete;
  bool isChecked;
  Function(bool?)? onChanged;

  TodoCard({super.key, required this.title, required this.description, required this.onPressedEdit, required this.onPressedDelete, required this.isChecked, required this.onChanged});

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 3),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        ),
        child: Row(
          children: [
            Checkbox(
              value: widget.isChecked, 
              onChanged: widget.onChanged
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 28, 62, 77),
                        fontSize: 15
                      ),
                    ),
                    Text(
                      widget.description,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 28, 62, 77)
                      ),
                    )
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: widget.onPressedEdit, 
              icon: const Icon(
                Icons.edit,
                color: Color.fromARGB(255, 28, 62, 77),
              )
            ),
            IconButton(
              onPressed: widget.onPressedDelete, 
              icon: const Icon(
                Icons.delete,
                color: Color.fromARGB(255, 28, 62, 77),
              )
            ),
          ],
        ),
      ),
    );
  }
}