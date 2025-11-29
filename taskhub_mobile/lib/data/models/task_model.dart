class CreateTaskRequest {
  final String title;
  final String? description;

  CreateTaskRequest({required this.title, this.description});

  Map<String, dynamic> toJson() => {
    'title': title,
    if (description != null) 'description': description,
  };
}

class UpdateTaskRequest {
  final String title;
  final String? description;
  final int status;

  UpdateTaskRequest({
    required this.title,
    this.description,
    required this.status,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    if (description != null) 'description': description,
    'status': status,
  };
}

class TaskResponse {
  final String id;
  final String title;
  final String? description;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;

  TaskResponse({
    required this.id,
    required this.title,
    this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TaskResponse.fromJson(Map<String, dynamic> json) {
    return TaskResponse(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      status: json['status'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
}
