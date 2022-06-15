// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:softwareapp_firebase/mesajEkrani.dart';
import 'package:softwareapp_firebase/models/Conversation.dart';
import 'package:softwareapp_firebase/viewmodel/sign_in_model.dart';
import 'package:softwareapp_firebase/viewmodel/sohbet_model.dart';

class Sohbet extends StatefulWidget {
  @override
  State<Sohbet> createState() => _SohbetState();
}

class _SohbetState extends State<Sohbet> {
  //const Sohbet({Key? key}) : super(key: key);

  //final String kullaniciId = "ASHfINCwe6R52R82Vzl8fH5NXKc2";

  @override
  FirebaseAuth auth = FirebaseAuth.instance;

  Widget build(BuildContext context) {
    // FirebaseFirestore.instance.collection("chats");

    final model = GetIt.instance<
        SohbetModel>(); //servis locatordan chatsmodelimizi çağırdık
    final user = Provider.of<signInModel>(context).currentUser;
    //print(user!.uid);
    return ChangeNotifierProvider(
      create: (BuildContext context) =>
          model, //bu işlemi yaparak minik bir memory optimizasyonu yapıyoruz. Çünkü dispose ediliyor modelim
      child: StreamBuilder<List<Conversation>>(
        stream: model.sohbetler(user!.uid),
        //builder: (BuildContext context, stream)
        builder:
            (BuildContext context, AsyncSnapshot<List<Conversation>> snapshot) {
          if (snapshot.hasError) {
            return Text('Error 404');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading.."); //verilerimiz yüklenme durumunda
          }
          return ListView(
            children: snapshot.data!
                .map((Conversation) => ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(Conversation.profileImage),
                      ),
                      title: Text(Conversation.userName),
                      subtitle: Text(Conversation.mesajlarial),
                      trailing: Column(children: [
                        Text("19.30",
                            style: TextStyle(
                                fontSize: 12.0, fontWeight: FontWeight.bold)),
                        Container(
                            width: 25.0,
                            height: 25.0,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(35.0)),
                            child: Center(
                              child: Text("16",
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold)),
                            ))
                      ]),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => mesajEkrani(
                                      kullaniciId: user.uid,
                                      conversation: Conversation,
                                    )));
                      },
                    ))
                .toList(),
          );
        },
      ),
    );
  }
}
