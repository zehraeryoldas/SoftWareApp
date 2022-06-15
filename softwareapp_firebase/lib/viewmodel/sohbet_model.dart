import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:softwareapp_firebase/core/services/sohbetservis.dart';
import 'package:softwareapp_firebase/viewmodel/base_model.dart';

import '../models/Conversation.dart';

class SohbetModel extends BaseModel {
  //ChangeNotifier:datalarda herhangi bir değişiklik olduğunda notifier listener metodunu çağırarak ui yeniden rebuld edilmesi sağlanır.
  final SohbetServis db = GetIt.instance<SohbetServis>();
  Stream<List<Conversation>> sohbetler(String kullaniciId) {
    return db.getSohbetler(kullaniciId);
  }
}
