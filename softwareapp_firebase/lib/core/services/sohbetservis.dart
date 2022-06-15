import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:softwareapp_firebase/models/Conversation.dart';
import 'package:softwareapp_firebase/models/profile.dart';

class SohbetServis {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Conversation>> getSohbetler(String kullaniciId) {
    var ref = _firestore
        .collection('conversations')
        .where('uyeler', arrayContains: kullaniciId);

    var conversationsStream = ref.snapshots();
    var profileStreams = getContacts()
        .asStream(); //bütün kullanıcıları lokal bir değişkene tanımladık. fututre den streame dönüştürdük

    return Rx.combineLatest2(
        //bu şekilde iki streamı birleştirip yeni bir stream olarak döndürecez
        conversationsStream,
        profileStreams,
        (QuerySnapshot conversations, List<Profile> profiles) =>
            conversations.docs.map(
              (snapshot) {
                //uyelerin içindeki bana ait olmayan useri çekip bu user bilgisini from snapshot metoduna göndermek
                List<String> uyeler = List.from(snapshot['uyeler']);
                //bundan sonraki olay öbür profili oradaki profile içerisinde aramak
                var profile = profiles.firstWhere((profile) =>
                    profile.id ==
                    uyeler.firstWhere((uye) => uye != kullaniciId));
                return Conversation.fromSnapshot(snapshot, profile);
              },
            ).toList());
  }

//bu servis clası üzerinden kişilerimizi döndürebilelim
  Future<List<Profile>> getContacts() async {
    // var ref = _firestore.collection('profile').orderBy('userName');
    var arkadaslar = await _firestore
        .collection('girisler')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('arkadaslar')
        .get();

    var list = arkadaslar.docs.map((item) => item.id).toList();

    var ref = _firestore
        .collection('profile')
        .where(FieldPath.documentId, whereIn: list);

    var profiles = await ref.get();

//profiles değişkenini query snapshotdan profile çevirelim
    return profiles.docs
        .map((snapshot) => Profile.fromSnapshot(snapshot))
        .toList();
  }
  //servisten bütün kişileri çekip ekrana yazdırabiliriz.

  Future<Conversation> startConversation(User user, Profile profile) async {
    var ref = _firestore.collection('conversations');
    var documentRef = await ref.add({
      'mesajlarial': '',
      'uyeler': [user.uid, profile.id],
    });

    //Kaydettiğimiz sohbeti döndürelim
    return Conversation(
        id: documentRef.id,
        userName: profile
            .userName, //burada kendi ismimizi değil sohbeti başlattığımız kişşişn ismini göndereceğiz
        profileImage: profile.image,
        mesajlarial: '');
  }
}
