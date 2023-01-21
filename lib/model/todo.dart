class ToDo {
  String? id;
  String? todoText;
  String? description;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.description,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(
          id: '01',
          todoText: 'Task1',
          description: 'Description1',
          isDone: true),
      ToDo(
          id: '02',
          todoText: 'Task2',
          description: 'Description2',
          isDone: true),
      ToDo(
          id: '03',
          todoText: 'Task3',
          description: 'Description3',
          isDone: false),
      ToDo(
          id: '04',
          todoText: 'Task4',
          description: 'Description4',
          isDone: false),
      ToDo(
          id: '05',
          todoText: 'Task5',
          description: 'Description5',
          isDone: false),
    ];
  }
}
