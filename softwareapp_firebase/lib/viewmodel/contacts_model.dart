import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import 'package:softwareapp_firebase/core/services/sohbetservis.dart';
import 'package:softwareapp_firebase/mesajEkrani.dart';
import 'package:softwareapp_firebase/models/profile.dart';

import 'base_model.dart';

class ContactsModel extends BaseModel {
  final SohbetServis sohbetServis = GetIt.instance<SohbetServis>();

  Future<List<Profile>> getContacts(String query) async {
    var contacts = await sohbetServis.getContacts();
    var kisilerifiltrele = contacts
        .where(
          (profile) => profile.userName.startsWith(
              query), //benim querye gönderdiğim isimle userName filtrelenecek
        )
        .toList();
    return kisilerifiltrele;
  }

//filtrelediğimiz kişiler arasında sohbet açma
  Future<void> startConversation(User user, Profile profile) async {
    var conversation = await sohbetServis.startConversation(user, profile);
    //user'ı mesaj ekranına yönlendirelim
    return navigatorService.navigateTo(
        mesajEkrani(kullaniciId: user.uid, conversation: conversation));
  }
}
