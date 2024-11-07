class Todo {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime createdAt;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.createdAt
  });


  factory Todo.fromJson(Map<String , dynamic> json){
    return Todo(
      id: json['_id'], 
      title: json['title'], 
      description: json['description'],
      isCompleted: json['isCompleted'],
      createdAt: DateTime.parse(json['createdAt']),
      );
  }

  Map<String , dynamic> toJson(){
    return {
      '_id' : id,
      'title' : title,
      "description" : description,
      'isCompleted' : isCompleted,
      'createdAt' : createdAt.toIso8601String(),
    };
  }
}