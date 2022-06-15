import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:softwareapp_firebase/core/locator.dart';
import 'package:softwareapp_firebase/sohbet.dart';
import 'package:softwareapp_firebase/viewmodel/main_model.dart';

import 'arama.dart';
import 'camera.dart';
import 'durum.dart';

/*Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}*/

/*class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "SoftwareApp",
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: AnaEkran(),
    );
  }
}*/

class AnaEkran extends StatefulWidget {
  const AnaEkran({Key? key}) : super(key: key);

  @override
  State<AnaEkran> createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _showMessage = true;

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(vsync: this, length: 4, initialIndex: 1);
    _tabController.addListener(() {
      _showMessage = _tabController.index != 0;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var model = GetIt.instance<MainModel>();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.black,
              size: 20.0,
            ),
            onPressed: () {},
          ),
          title: Text(
            "SoftWareApp",
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications,
                  color: Colors.yellow,
                ))
          ],
          //ÜST TARAFDAKİ NAVİGASYON PARAMETRELERİNİ YAZALIM
          bottom: TabBar(
              //controller parametresini ekleyelim buna
              controller: _tabController,
              tabs: [
                Tab(
                  icon: IconButton(
                    icon: Icon(Icons.camera_alt_outlined),
                    onPressed: () {
                      Camera().fotoCek();
                    },
                  ),
                  child: Container(color: Colors.blue),
                ),
                Tab(
                  text: "Sohbetler",
                ),
                Tab(
                  text: "Durum",
                ),
                Tab(
                  text: "Aramalar",
                ),
              ]),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            Camera(),
            Sohbet(),
            durum(),
            arama(),
          ],
        ),
        floatingActionButton: _showMessage
            ? FloatingActionButton(
                child: Icon(
                  Icons.message,
                  color: Colors.yellow,
                ),
                onPressed: () async {
                  await model.navigateToContacts();
                },
              )
            : null);
  }
}

//SAYFA GEÇİŞLERİ HAKKINDA

/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:softwareapp_firebase/Sohbet.dart';

import 'girisEkrani.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DogrulamaEkrani(),
    );
  }
}

class DogrulamaEkrani extends StatefulWidget {
  const DogrulamaEkrani({Key? key}) : super(key: key);

  @override
  State<DogrulamaEkrani> createState() => _DogrulamaEkraniState();
}

class _DogrulamaEkraniState extends State<DogrulamaEkrani> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  Future<void> kayitOl() async {
    await FirebaseAuth.instance //.then bu işlem tamamlandıktan sonra
        .createUserWithEmailAndPassword(email: t1.text, password: t2.text)
        .then((kullanici) {
      //kullanıcı kayıt işlemi tamamlandı buraya kadar
      FirebaseFirestore.instance.collection("Oturumlar").doc(t1.text).set({
        'eposta': t1.text,
        'sifre': t2.text
      }); //set de map yapısı oluşturuyoruz
    });
  }

  gecisYap() {
    setState(() {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => AnaEkran()));
    });
  }

  girisYap() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: t1.text, password: t2.text)
        .then((kullanici) {
      gecisYap();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("                 Doğrulama Ekranı")),
      body: Column(children: [
        Center(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(width: 5.0, color: Colors.grey.shade200),
                color: Colors.grey.shade100),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: "eposta"),
                  controller: t1,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "sifre"),
                  controller: t2,
                ),
                Row(
                  children: [
                    ElevatedButton(onPressed: kayitOl, child: Text("Kaydol")),
                    ElevatedButton(
                        onPressed: girisYap, child: Text("Giriş Yap"))
                  ],
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
*/