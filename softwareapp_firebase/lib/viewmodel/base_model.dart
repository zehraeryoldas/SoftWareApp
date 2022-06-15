import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:softwareapp_firebase/core/services/navigatorservis.dart';

abstract class BaseModel with ChangeNotifier {
  final NavigatorService navigatorService = GetIt.instance<
      NavigatorService>(); //bu servisi bütün viewmodellerde kullanabileceğimizi için buraya taşıdık

//kullanıcı giriş yap butonuna sürekli tıklamasın diye loading işlemi ekledik
//view de bir değişiklik var mı acaba?
  bool _busy = false;

  bool get busy => _busy;

  set busy(bool state) {
    _busy = state;

    notifyListeners(); //bu metodu çağırmamızın sebebi busy fieldinin değeri değiştiğinde  notify listeners fonksiyonu çağrılır.
  } //view de bir değişiklik olduğunu provider widgetına belirteyim
}
