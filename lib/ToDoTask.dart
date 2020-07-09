import 'package:flutter/material.dart';

class ToDoTask{

  final int id;
  final int userId;
  final String title;
  final bool completed;

  ToDoTask({
    @required this.id,
    @required this.userId,
    @required this.title, 
    @required this.completed
  });

  factory ToDoTask.fromJson(Map<String, dynamic> json) {
    return new ToDoTask(
      id: json['id'], 
      userId: json['userId'], 
      title: json['title'], 
      completed: json['completed']);
  }
}