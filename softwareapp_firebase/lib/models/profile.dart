import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/foundation/key.dart';

class Profile {
  String id;
  String userName;
  String image;

  Profile(
      {required this.id,
      required this.userName,
      required this.image,
      Key? key});

//map den objeye döndürmek için
  factory Profile.fromSnapshot(DocumentSnapshot snapshot) {
    return Profile(
        id: snapshot.id,
        userName: snapshot['userName'],
        image: snapshot['image']);
  }
}
