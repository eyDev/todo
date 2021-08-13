import 'package:eydev_todos/src/data/Constants.dart';
import 'package:eydev_todos/src/data/TodosBloc.dart';
import 'package:flutter/material.dart';

class TodosList extends StatelessWidget {
  const TodosList({Key? key, required this.snapshot}) : super(key: key);
  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final Constants _constants = Constants();
    final TodosBloc db = TodosBloc();

    if (!snapshot.hasData) {
      return Center(child: CircularProgressIndicator());
    }
    final todos = snapshot.data;
    if (todos!.length == 0) {
      return Center(
        child: Image.asset(
          'assets/empty.png',
          width: MediaQuery.of(context).size.width / 2,
        ),
      );
    }
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, i) => Dismissible(
        key: UniqueKey(),
        background: Card(color: Colors.redAccent),
        onDismissed: (direction) => db.tdDeleteTodo(todos[i].id!),
        child: Card(
          elevation: 2,
          margin: EdgeInsets.only(right: 10, left: 10, top: 10),
          child: CheckboxListTile(
            activeColor: _constants.primaryColor,
            controlAffinity: ListTileControlAffinity.leading,
            value: todos[i].isCompleted,
            onChanged: (value) => db.tdUpdateTodo(todos[i].id, !todos[i].isCompleted),
            title: Text(
              todos[i].todo,
              style: TextStyle(
                decoration: todos[i].isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text('${todos[i].finishDate.day} / ${todos[i].finishDate.month} / ${todos[i].finishDate.year}'),
          ),
        ),
      ),
    );
  }
}
