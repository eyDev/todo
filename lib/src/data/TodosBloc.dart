import 'dart:async';

import 'package:eydev_todos/src/data/TodosDatabase.dart';
import 'package:eydev_todos/src/model/TodoModel.dart';

class TodosBloc {
  static final TodosBloc tdbloc = new TodosBloc._internal();

  factory TodosBloc() {
    return tdbloc;
  }

  TodosBloc._internal() {
    tdGetTodos();
  }

  final _todosController = StreamController<List<TodoModel>>.broadcast();

  Stream<List<TodoModel>> get todosStream => _todosController.stream;

  dispose() {
    _todosController.close();
  }

  tdGetTodos() async {
    _todosController.sink.add(await TodosDatabase.db.getTodos());
  }

  tdNewTodo(TodoModel todo) async {
    await TodosDatabase.db.newTodo(todo);
    tdGetTodos();
  }

  tdUpdateTodo(int id, bool isCompleted) async {
    await TodosDatabase.db.updateTodo(id, isCompleted);
    tdGetTodos();
  }

  tdDeleteTodo(int id) async {
    await TodosDatabase.db.deleteTodo(id);
    tdGetTodos();
  }

  tdDeleteAllTodos() async {
    TodosDatabase.db.deleteALlTodos();
    tdGetTodos();
  }
}
