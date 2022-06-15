import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:softwareapp_firebase/core/locator.dart';
import 'package:softwareapp_firebase/viewmodel/sign_in_model.dart';

class girisSayfasi extends StatelessWidget {
  const girisSayfasi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController t1 = TextEditingController();
    final TextEditingController t2 = TextEditingController();
    return ChangeNotifierProvider(
        create: (BuildContext context) =>
            GetIt.instance<signInModel>(), //clasımızı getit üzerinden çekelim.

        child: Consumer<signInModel>(
          builder: (BuildContext context, signInModel model, child) => Scaffold(
            appBar: AppBar(title: Text("SoftwareApp giriş yap")),
            body: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: model.busy //networkle ilgili bir işlem oluyorsa eğer
                    ? CircularProgressIndicator()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            Text('Kullanici Adi'),
                            TextField(
                              controller: t1,
                            ),
                            Text('Şifre'),
                            TextField(
                              controller: t2,
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  await model.signIn(t1.text, t2.text);
                                },
                                child: Text('Giriş Yap'))
                          ]),
              ),
            ),
          ),
        ));
  }
}























/*import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:softwareapp_firebase/sohbet.dart';

import 'arama.dart';
import 'camera.dart';
import 'durum.dart';
import 'mesajEkrani.dart';

/*Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
*/
class MyApp extends StatelessWidget {
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
}

class AnaEkran extends StatefulWidget {
  const AnaEkran({Key? key}) : super(key: key);

  @override
  State<AnaEkran> createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(
      length: 4,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                icon: Icon(Icons.camera_alt_outlined),
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
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.message,
          color: Colors.yellow,
        ),
        onPressed: () {
          /* Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => Kullanici()));*/
        },
      ),
    );
  }
}*/

//SAYFA GEÇİŞLERİ HAKKINDA