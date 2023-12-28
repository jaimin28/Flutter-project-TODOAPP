import 'package:ToDoApp/models/Classes/todoitem.dart';
import 'package:ToDoApp/models/widgets/intray_tool_widget.dart';
import 'package:flutter/material.dart';
import '../../global.dart';

class IntrayPage extends StatefulWidget {
  @override
  _IntrayPageState createState() => _IntrayPageState();
}

class _IntrayPageState extends State<IntrayPage> {
  List<Task> taskList = [];
  @override
  Widget build(BuildContext context) {
    taskList = getlist();
    return Container(
      color: darkGreyColor,
      child: _buildReorderableListSimple(context),
      //  child: ReorderableListView(
      //    padding: EdgeInsets.only(top: 300),
      //    children: todoItems,
      //    onReorder: _onReorder,
      //  ),
    );
  }

  Widget _buildListTile(BuildContext context, Task item) {
    return ListTile(
      key: Key(item.taskId),
      title: IntrayTodo(
        title: item.title,
      ),
    );
  }

  Widget _buildReorderableListSimple(BuildContext context) {
    return Theme(
      data: ThemeData(canvasColor: Colors.transparent),
      child: ReorderableListView(
        // handleSide: ReorderableListSimpleSide.Right,
        // handleIcon: Icon(Icons.access_alarm),
        padding: EdgeInsets.only(top: 300.0),
        children:
            taskList.map((Task item) => _buildListTile(context, item)).toList(),
        onReorder: (oldIndex, newIndex) {
          setState(() {
            Task item = taskList[oldIndex];
            taskList.remove(item);
            taskList.insert(newIndex, item);
          });
        },
      ),
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final Task item = taskList.removeAt(oldIndex);
      taskList.insert(newIndex, item);
    });
  }

  List<Task> getlist() {
    for (int i = 0; i < 10; i++) {
      taskList.add(Task("My First Todo" + i.toString(), false, i.toString()));
    }
    return taskList;
  }
}
