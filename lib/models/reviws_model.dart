import 'package:flutter/cupertino.dart';

class Reviews{
  final String id;
  final String name;
  final String imageUrl;
  final String content;
  Reviews({ this.name='', this.imageUrl='', this.content='', this.id=''});
  Reviews.fromMap(Map snapshot, String id)
      : id = id,
        name = snapshot['name'] ?? 'اسم مستخدم',
        imageUrl = snapshot['imageUrl'] ?? '',
        content = snapshot['message'] ?? '';
        // joinDate = DateTime.parse(snapshot['joinDate']) ?? DateTime.now(),
        // itemsDonated = snapshot['itemsDonated'] ?? 0,
        // completedTasks = snapshot['completedTasks'] ?? 0,
        // phoneNumber =  snapshot['phoneNumber'] ?? "",
        // type =  snapshot['type'] ?? "";


  toJson() {
    return {
      "name" : name,
      "imageUrl": imageUrl,
      "message": content,
      // "joinDate": joinDate.toString(),
      // "itemsDonated": itemsDonated,
      // "phoneNumber" : phoneNumber,
      // "completedTasks": completedTasks,
      // "type":type,
    };
  }
}