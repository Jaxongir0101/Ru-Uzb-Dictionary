import 'package:flutter/material.dart';
import 'package:rus_uzb/main_proider.dart';
import 'package:rus_uzb/screens/widgets/word_list.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "Search query";
  bool _isSlovo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        leading: _isSearching ? const BackButton() : Container(),
        title: _buildSearchField(),
        actions: _buildActions(),
      ),
      body: const WordList(),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      autocorrect: true,
      controller: _searchQueryController,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: "Search Data...",
        hintStyle: TextStyle(color: Colors.white70),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: (query) => updateSearchQuery(query),
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQueryController == null ||
                _searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),

      IconButton(
        icon: const Icon(Icons.star_outline),
        onPressed: () {
          
        },
      ),
      ////// star

      InkWell(
        onTap: () {
          final mainProvider =
              Provider.of<MainProvider>(context, listen: false);
          mainProvider.change();
          _isSlovo = !_isSlovo;
        },
        child: Container(
            height: 24,
            width: 24,
            child: Image.asset(
              "assets/image/change.png",
              color: Colors.white,
            )),
      ),

      SizedBox(
        width: 16,
      )
    ];
  }

  void _startSearch() {
    ModalRoute.of(context)
        ?.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void updateSearchQuery(String newQuery) {
    searchQuery = newQuery;
    updateQuery(word: searchQuery);
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }

  void updateQuery({
    String? word,
  }) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    mainProvider.initList(
      word: word,
      isSlovo: _isSlovo,
    );
  }
}
