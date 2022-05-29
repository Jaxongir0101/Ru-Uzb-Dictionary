import 'package:flutter/widgets.dart';
import 'package:rus_uzb/database_helper.dart';
import 'package:rus_uzb/models/word.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainProvider extends ChangeNotifier {
  final List<Word> words = [];
  bool isWord = false;

  initList({String? word, bool? isSlovo}) async {
    words.clear();
    if (word == null) {
      words.addAll(await DatabaseHelper.intance.getWords());
    } else {
      words.addAll(await DatabaseHelper.intance.getWordLike(word, isSlovo!));
    }

    notifyListeners();
  }

  change() {
    isWord = !isWord;
    notifyListeners();
  }


}
