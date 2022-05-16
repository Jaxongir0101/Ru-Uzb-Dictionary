import 'package:flutter/material.dart';
import 'package:rus_uzb/models/word.dart';
import 'package:rus_uzb/screens/details_page.dart';

class WordItem extends StatelessWidget {
  final Word word;
  const WordItem(this.word, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => DetailsPage(word)));
      },
      child: Card(
        elevation: 8,
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  word.uzb ?? "...",
                ),
              ),
              const Icon(
                Icons.chevron_right_outlined,
                size: 32,
                color: Colors.black38,
              )
            ],
          ),
        ),
      ),
    );
  }
}
