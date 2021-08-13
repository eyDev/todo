import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:eydev_todos/src/data/Constants.dart';
import 'package:eydev_todos/src/data/TodosBloc.dart';
import 'package:eydev_todos/src/model/TodoModel.dart';
import 'package:eydev_todos/src/widgets/SnackBarError.dart';
import 'package:flutter/material.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _todoData = TextEditingController();
  final TodosBloc db = TodosBloc();
  final Constants _constants = Constants();
  DateTime _selectedValue = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Añadir nueva tarea'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    maxLines: null,
                    controller: _todoData,
                    decoration: InputDecoration(
                      labelText: 'Tarea',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: _constants.primaryColor),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Rellene el campo.';
                      }
                    },
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 20),
                  DatePicker(
                    DateTime.now(),
                    initialSelectedDate: DateTime.now(),
                    selectionColor: Colors.black,
                    selectedTextColor: Colors.white,
                    onDateChange: (date) {
                      // New date selected
                      setState(() {
                        _selectedValue = date;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width, 60)),
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        db.tdNewTodo(TodoModel(todo: _todoData.text, isCompleted: false, finishDate: _selectedValue));
                        Navigator.pop(context);
                        showInSnackBar(context, 'Tarea Añadida', Colors.green);
                      }
                    },
                    child: Text(
                      'Aceptar',
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancelar',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
