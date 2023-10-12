import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
List<TodoModel> todoModelsFromJsonList(String jsonString) {
  final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;
  return jsonList
      .map((item) => TodoModel.fromMap(item as Map<String, dynamic>))
      .toList();
}

String todoModelsListToJson(List<TodoModel> todoModels) {
  final List<Map<String, dynamic>> todoMapList =
      todoModels.map((todo) => todo.toMap()).toList();
  return json.encode(todoMapList);
}

class TodoModel {
  final String id;
  final String description;
  final bool isCompleted;
  TodoModel({
    required this.id,
    required this.description,
    required this.isCompleted,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'description': description,
      'isCompleted': isCompleted,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'] as String,
      description: map['description'] as String,
      isCompleted: map['isCompleted'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoModel.fromJson(String source) =>
      TodoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  TodoModel copyWith({
    String? id,
    String? description,
    bool? isCompleted,
  }) {
    return TodoModel(
      id: id ?? this.id,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  String toString() =>
      'TodoModel(id: $id, description: $description, isCompleted: $isCompleted)';
}
