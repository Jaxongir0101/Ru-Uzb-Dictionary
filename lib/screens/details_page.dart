import 'package:flutter/material.dart';

import 'package:rus_uzb/models/word.dart';

class DetailsPage extends StatelessWidget {
  final Word word;
  final bool isWord;
  const DetailsPage(this.word, this.isWord, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isWord ? word.rus! : word.uzb ?? "...",
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
              Text(  isWord ? word.uzb! : word.rus ?? "...",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                  isWord ? word.rus! : word.uzb ?? "...",
                style: TextStyle(fontSize: 28),
              )
            ],
          )
        ],
      ),
    );
  }
}
