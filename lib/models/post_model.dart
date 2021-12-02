import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? id;
  String? description;
  String? imageUrl;

  PostModel(
      {required this.id,
      required this.description,
      required this.imageUrl});

  factory PostModel.fromSnapshot(DocumentSnapshot snapshot) {
    return PostModel(
        id: snapshot['id'],
        description: snapshot['description'],
        imageUrl: snapshot['imageUrl']);
  }
}
