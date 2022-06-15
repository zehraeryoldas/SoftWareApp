// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:softwareapp_firebase/models/Conversation.dart';
import 'package:softwareapp_firebase/softwareApp.dart';

import 'girisEkrani.dart';
import 'main.dart';
//import 'package:software_app/AnaSayfa.dart';

class mesajEkrani extends StatefulWidget {
  //const mesajEkrani({Key? key}) : super(key: key);

  final String kullaniciId;
  final Conversation conversation;

  const mesajEkrani(
      {super.key, required this.kullaniciId, required this.conversation});

  @override
  State<mesajEkrani> createState() => _mesajEkraniState();
}

class _mesajEkraniState extends State<mesajEkrani> {
  late CollectionReference _ref;
  final TextEditingController t1 = TextEditingController();
  late FocusNode focusNode;
  late ScrollController _scrollController;

  @override
  void initState() {
    _ref = FirebaseFirestore.instance
        .collection("conversations/${widget.conversation.id}/mesajlar");
    //birbirine bağlama işlemi gerçekleştirdik//gönderdiğimiz sohbetId ye
    //ait bütün mesajları çekip ilgili referansı buradaki ref isimli fielda eşitlemiş olduk

    focusNode = FocusNode();
    _scrollController = ScrollController();

    // TODO: implement initState
    super.initState();
  }

//focusnodeu dispose edelim ki memorylik bir işlem olmasın
  @override
  void dispose() {
    // TODO: implement dispose
    focusNode.dispose();
    _scrollController.dispose();

    super.dispose();
  }

  List mesajListesi = [];

  MesajEkle(String text) async {
    setState(() {
      FirebaseFirestore.instance
          .collection("conversations/${widget.conversation.id}/mesajlar")
          .doc(t1.text)
          .set({
        "mesaj": t1.text,
        "gonderenId": widget.kullaniciId,
        "timeStamp": DateTime.now()
      }).whenComplete(() => print("Mesaj eklendi"));

      mesajListesi.insert(0, text);
      t1.clear();
    });
  }

  anasayfaDonus() {
    setState(() {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => AnaEkran()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.conversation.profileImage),
            ),
            Text(widget.conversation.userName),
          ],
        ),
        backgroundColor: Colors.blue,
        actions: [
          //buraya aslında ınkwell de tanımlayıp iconlarımızı yazabiliriz.
          InkWell(onTap: anasayfaDonus, child: Icon(Icons.home)),
          SizedBox(
            width: 3.0,
          ),
          InkWell(onTap: () {}, child: Icon(Icons.call)),
          InkWell(onTap: () {}, child: Icon(Icons.more_vert)),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.grey.shade100),
        child: Column(
          children: [
            Expanded(
                child: StreamBuilder(
              stream: _ref.orderBy('timeStamp').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else {
                  var docs = snapshot.data!.docs;
                  return ListView(
                      controller: _scrollController,
                      reverse: true,
                      children: docs
                          .map(
                            (doc) => ListTile(
                              title: Align(
                                  alignment:
                                      widget.kullaniciId != doc['gonderenId']
                                          ? Alignment.centerLeft
                                          : Alignment.centerRight,
                                  child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Colors.blue.withOpacity(0.5),
                                          borderRadius: BorderRadius.horizontal(
                                              left: Radius.circular(40),
                                              right: Radius.circular(40))),
                                      child: Text(doc['mesaj'],
                                          style:
                                              TextStyle(color: Colors.black)))),
                            ),
                          )
                          .toList());
                }
              },
            )),
            Row(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      focusNode: focusNode,
                      controller: t1,
                      decoration: InputDecoration(labelText: "Mesaj"),
                      onSubmitted:
                          MesajEkle, //bunun içine(mesajekle(t1.text) yazarsak mesaj atamayız)
                    ),
                  ),
                ),
                IconButton(
                    //onPressed: () => MesajEkle(t1.text),
                    onPressed: () async {
                      await _ref.add({
                        'gonderenId':
                            widget //sohbeti gönderenin kulanici ıd sini alalım bu işlemle
                                .kullaniciId, //sohbeti gönderen kişinin kullanıcı id sini alalım
                        'mesaj': t1.text,
                        'timeStamp': DateTime.now()
                      });
                      _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeIn);

                      t1.clear();
                    },
                    //iconbutton yapısı onpressed işlemini isimsiz bir fonksiyon yardımıyla ister (  ()=> ) aksi takdirde offline dir
                    icon: Icon(
                      Icons.send,
                      color: Colors.blue,
                    )),
                IconButton(onPressed: () {}, icon: Icon(Icons.camera_alt))
              ],
            )
          ],
        ),
      ),
    );
  }
}
