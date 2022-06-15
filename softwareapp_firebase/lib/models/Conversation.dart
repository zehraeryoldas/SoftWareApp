// ignore_for_file: empty_constructor_bodies

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:softwareapp_firebase/core/services/sohbetservis.dart';
import 'package:softwareapp_firebase/models/profile.dart';

class Conversation {
  String id;
  String userName;
  String profileImage;
  String mesajlarial;

  Conversation(
      {required this.id,
      required this.userName,
      required this.profileImage,
      required this.mesajlarial});

  factory Conversation.fromSnapshot(
      //fromsnapshot metodu documentsnapshot tipinde snapshot isimli bir parametre tanımladık
      //Bu şekilde from snapshot metoduna documentsnapshotu göndererek conversation objesini
      //oluşturup  factory class olarak geri döndürüyoruz.
      DocumentSnapshot snapshot,
      Profile profile) {
    return Conversation(
        id: snapshot.id,
        userName: profile.userName,
        profileImage: profile.image,
        mesajlarial: (snapshot.data as DocumentSnapshot)['mesajlarial']);
  }
}
