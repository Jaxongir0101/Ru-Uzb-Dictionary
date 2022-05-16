import 'package:flutter/material.dart';
import 'package:rus_uzb/main_proider.dart';
import 'package:rus_uzb/models/word.dart';

class DetailsPage extends StatelessWidget {
  final Word word;
  const DetailsPage(this.word, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          word.uzb ?? "...",
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 72,
              ),
              Text(word.uzb??".."),
              SizedBox(
                height: 16,
              ),
              Text(
                word.rus ?? "...",
                style: TextStyle(fontSize: 24),
              )
            ],
          )
        ],
      ),
    );
  }
}
