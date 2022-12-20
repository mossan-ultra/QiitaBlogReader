import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Notifier/SettingsState.dart';

class KeywordInputMenu extends StatefulWidget {
  const KeywordInputMenu({super.key});

  @override
  State<KeywordInputMenu> createState() => _KeywordInputMenu();
}

class _KeywordInputMenu extends State<KeywordInputMenu> {
  List<String> _keyword = ['react', 'AWS'];
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void textOnSubmit(String text) {
    Provider.of<SettingsState>(context, listen: false).AddKeyword(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KeywordInputMenu'),
      ),
      body: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          TextField(
              enabled: true,
              // 入力数
              maxLength: 10,
              style: TextStyle(color: Colors.red),
              obscureText: false,
              maxLines: 1,
              onSubmitted: (String str) {
                textOnSubmit(str);
              }),
          for (String text in Provider.of<SettingsState>(context).keywordList)
            Row(
              children: [
                SizedBox(
                  child: Text(
                    text,
                    style: const TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 32),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Provider.of<SettingsState>(context, listen: false)
                        .RemoveKeyword(text);
                  },
                  key: Key(text),
                  child: const Text('DEL'),
                )
              ],
            )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'add'),
        ],
        currentIndex: _currentIndex,
        fixedColor: Colors.blueAccent,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
