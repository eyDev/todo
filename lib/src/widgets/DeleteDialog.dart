import 'package:eydev_todos/src/data/Constants.dart';
import 'package:eydev_todos/src/data/TodosBloc.dart';
import 'package:eydev_todos/src/widgets/SnackBarError.dart';
import 'package:flutter/material.dart';

class DeleteDialog extends StatefulWidget {
  const DeleteDialog({
    Key? key,
  }) : super(key: key);

  @override
  _DeleteDialogState createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
  final Constants _constants = Constants();
  final TodosBloc db = TodosBloc();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 1,
      title: Text(
        'Eliminar Tareas',
        textAlign: TextAlign.center,
      ),
      content: Text(
        '¿Está seguro que desea eliminar todas las tareas?',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancelar',
            style: TextStyle(color: _constants.primaryColor),
          ),
        ),
        TextButton(
          onPressed: () {
            db.tdDeleteAllTodos();
            Navigator.pop(context);
            showInSnackBar(context, 'Eliminado!', Colors.redAccent);
          },
          child: Text(
            'Aceptar',
            style: TextStyle(color: _constants.primaryColor),
          ),
        ),
      ],
    );
  }
}
