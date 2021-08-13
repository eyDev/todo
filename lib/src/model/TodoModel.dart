class TodoModel {
  final int? id;
  final String todo;
  final bool isCompleted;
  final DateTime finishDate;

  TodoModel({
    this.id,
    required this.todo,
    required this.isCompleted,
    required this.finishDate,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) => new TodoModel(
        id: json['id'],
        todo: json['todo'],
        isCompleted: json['isCompleted'] == 1 ? true : false,
        finishDate: DateTime.parse(json['finishDate']),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "todo": todo,
        "isCompleted": isCompleted ? 1 : 0,
        "finishDate": finishDate.toString(),
      };
}
