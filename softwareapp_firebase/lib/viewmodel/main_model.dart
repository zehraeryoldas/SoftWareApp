import 'package:softwareapp_firebase/core/services/navigatorservis.dart';
import 'package:softwareapp_firebase/viewmodel/base_model.dart';

import '../contacts.dart';

class MainModel extends BaseModel {
  Future<void> navigateToContacts() {
    return navigatorService.navigateTo(ContactsPage());
  }
}
