import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:softwareapp_firebase/core/locator.dart';
import 'package:softwareapp_firebase/core/services/authservis.dart';
import 'package:softwareapp_firebase/core/services/navigatorservis.dart';
import 'package:softwareapp_firebase/softwareApp.dart';
import 'package:softwareapp_firebase/viewmodel/base_model.dart';

class signInModel extends BaseModel {
  final AuthServis _authServis = GetIt.instance<AuthServis>();
  //kullanıcı profilini açmak için bu işlemi uyguladık bottom line
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? get currentUser => _authServis.currentUser;

  Future<dynamic> signIn(String userName, String password) async {
    if (userName.isEmpty || password.isEmpty) {
      return;
    }
    busy = true; // bu işlemle ekrana loading barı göstereceğiz
    try {
      //kullanıcı signın işlemini tamamladıktan sonra bize dönen userı collectiona eklesin
      var user = await _authServis.signIn(userName, password);
      await _firestore.collection('girisler').doc(user!.uid).set({
        'userName': userName,
      });
      await navigatorService.navigateToReplace(AnaEkran());
    } catch (e) {
      busy = false;
    }
    //signIn metodu exception oluşturduğu içn try catch içinde yazmalıyız
    busy = false; //false yapaark artık bir işlemin olmadığını belirtelim.
  }
}
