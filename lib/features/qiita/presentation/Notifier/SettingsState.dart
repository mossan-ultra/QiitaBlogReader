import 'package:flutter/cupertino.dart';

class SettingsState extends ChangeNotifier {
  List<String> keywordList = ['react', 'AWS'];

  void AddKeyword(String keyword) {
    keywordList.add(keyword);
    notifyListeners();
  }

  void RemoveKeyword(String keyword) {
    keywordList.remove(keyword);
    notifyListeners();
  }
}
