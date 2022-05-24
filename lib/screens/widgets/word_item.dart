import 'package:flutter/material.dart';
import 'package:rus_uzb/models/word.dart';
import 'package:rus_uzb/screens/details_page.dart';

class WordItem extends StatefulWidget {
  final Word word;
  final bool isWord;
const  WordItem(this.word, this.isWord, {Key? key}) : super(key: key);

  @override
  State<WordItem> createState() => _WordItemState();
}

class _WordItemState extends State<WordItem> {
  bool isTab = true;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailsPage(widget.word, widget.isWord)));
      },
      child: Card(
        elevation: 8,
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Row(
            children: [
              IconButton(
                icon: isTab
                    ?const Icon(Icons.star_outline)
                    :const Icon(
                        Icons.star,
                        color: Colors.black45,
                      ),
                onPressed: () {
                  setState(() {
                    isTab = !isTab;
                  });
                },
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.isWord ? widget.word.rus! : widget.word.uzb ?? "...",
                  style: const TextStyle(fontSize: 16),
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
