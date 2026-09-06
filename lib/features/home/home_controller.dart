import 'package:flutter/material.dart';

import '../../core/constants/storage_key.dart';
import '../../core/services/preferences_manager.dart';

class HomeController with ChangeNotifier {
  String? name;
  String? userImage;

  void init() {
    getUserData();
  }

  void getUserData() async {
    name = PreferencesManager().getString(StorageKey.userName);
    userImage = PreferencesManager().getString(StorageKey.userImage);
    notifyListeners();
  }
}
