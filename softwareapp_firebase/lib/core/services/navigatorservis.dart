import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigatorService {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  //bu key üzerinden routing işlemlerini yapabiliriz
  //bu key'e getter tanımladık
  //navigtor keyi dönsün bize
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  Future<dynamic> navigateTo(Widget route) {
    return _navigatorKey.currentState!
        .push(MaterialPageRoute(builder: (BuildContext context) => route));
  }

  //re routing olduğunda geri ok olmasın diye pushReplacement metodunu çağırıyoruz
  Future<dynamic> navigateToReplace(Widget route) {
    return _navigatorKey.currentState!.pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => route));
  }
}
