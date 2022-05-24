import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rus_uzb/models/word.dart';
import 'package:rus_uzb/utils/constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseHelper {
  static final DatabaseHelper intance = DatabaseHelper._instance();

  static Database? _db;

  DatabaseHelper._instance();

  final String tableName = "dictionary";

  final String colId = 'id';
  final String colRusWord = 'rus';
  final String colUzbWord = 'uzb';

  Future<Database?> get db async {
    return _db ?? await _initDB();
  }

  Future<Database?> _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "dictionary.db";

    _db = await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE $tableName ("
          "$colId INTEGER PRIMARY KEY,"
          "$colRusWord TEXT,"
          "$colUzbWord TEXT"
          ")");
    });
    return _db;
  }

  Future<void> loadDB(context) async {
    print("DATABASE HALPER");
    String data =
        await DefaultAssetBundle.of(context).loadString("assets/trans.json");
    final jsonResult = jsonDecode(data);

    List<Word> words = jsonResult.map<Word>((data) {
      return Word.fromJson(data);
    }).toList();

    for (var word in words) {
      await insert(word);
    }
    saveState();
  }

  Future<void> saveState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool(Constans.IS_DATABASE_INIT, true);
  }

  Future<Word> insert(Word word) async {
    final data = await db;
    word.id = await data?.insert(tableName, word.toMap());
    return word;
  }

  Future<List<Map<String, Object?>>?> getWordMap(
      {String? word, bool? isSlovo}) async {
    final data = await db;
    final List<Map<String, Object?>>? result;

    if (word == null) {
      result = await data?.query(tableName);
    } else {
      result = await data?.query(
        tableName,
        where: isSlovo! ?"rus LIKE ?":"uzb LIKE ?",
        whereArgs: ["$word%"],
      );
    }
    return result;
  }

  Future<List<Word>> getWords() async {
    final List<Map<String, Object?>>? taskMap = await getWordMap();
    final List<Word> words = [];
    taskMap?.forEach((element) {
      words.add(Word.fromMap(element));
    });
    return words;
  }

  Future<int?> update(Word word) async {
    final data = await db;
    return await data?.update(tableName, word.toMap(),
        where: "$colId = ?", whereArgs: [word.id]);
  }

  Future<int?> delete(int word) async {
    final data = await db;
    return await data?.delete(
      tableName,
      where: '$colId = ?',
      whereArgs: [word],
    );
  }

  Future<List<Word>> getWordLike(String word, bool isSlovo) async {
    final List<Map<String, Object?>>? taskMap =
        await getWordMap(word: word, isSlovo: isSlovo);
    final List<Word> words = [];
    taskMap?.forEach((element) {
      words.add(Word.fromMap(element));
    });
    return words;
  }
}
