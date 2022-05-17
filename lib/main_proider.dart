import 'package:flutter/widgets.dart';
import 'package:rus_uzb/database_helper.dart';
import 'package:rus_uzb/models/word.dart';

class MainProvider extends ChangeNotifier {
  final List<Word> words = [];
  bool isWord = false;

  initList({String? word}) async {
    words.clear();
    if (word == null) {
      words.addAll(await DatabaseHelper.intance.getTasks());
    } else {
      words.addAll(await DatabaseHelper.intance.getWordLike(word));
    }
    notifyListeners();
  }

  change(){
    isWord = !isWord;
    notifyListeners();
  }


}
