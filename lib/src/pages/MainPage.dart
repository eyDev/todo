import 'package:eydev_todos/src/data/TodosBloc.dart';
import 'package:eydev_todos/src/model/TodoModel.dart';
import 'package:eydev_todos/src/pages/AddTodoPage.dart';
import 'package:eydev_todos/src/widgets/DeleteDialog.dart';
import 'package:eydev_todos/src/widgets/TodosList.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final TodosBloc db = TodosBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _body(),
      bottomNavigationBar: _bottomNavigationBar(context),
    );
  }

  Widget _body() {
    return SafeArea(
      child: StreamBuilder<List<TodoModel>>(
          stream: db.todosStream,
          builder: (BuildContext context, AsyncSnapshot<List<TodoModel>> snapshot) {
            return TodosList(snapshot: snapshot);
          }),
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(icon: Icon(Icons.delete), onPressed: _deleteTodos),
          Text(
            'eydev - Tareas',
            style: TextStyle(fontSize: 18),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _addTodo(context),
          ),
        ],
      ),
    );
  }

  void _deleteTodos() => showDialog(
        context: context,
        builder: (BuildContext context) => DeleteDialog(),
      );

  void _addTodo(context) => Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddTodoPage()));
}
