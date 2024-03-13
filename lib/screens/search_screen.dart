import 'package:flutter/material.dart';
import 'package:news_pulse/models/news_model.dart';
import 'package:news_pulse/service/news_service.dart';
import 'package:news_pulse/widget/news_list_widget.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Article> searchResults = [];
  var newsService = NewsService();
  FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Automatically request focus when the screen is loaded
    _searchFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(12, 26),
                          blurRadius: 50,
                          spreadRadius: 0,
                          color: Colors.grey.withOpacity(.1),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      focusNode: _searchFocusNode,
                      onChanged: (onSearch) {
                        _performSearch(onSearch);
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey[500]!,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Search...',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w300,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 20.0,
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(45.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[300]!, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(45.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[400]!, width: 1.5),
                          borderRadius: BorderRadius.all(Radius.circular(45.0)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  // Add any additional widgets for filters or sorting options
                ],
              ),
            ),
          ),
          Expanded(
            child: _buildSearchResults(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    if (searchResults.isEmpty) {
      return Center(
        child: Text('No results found'),
      );
    } else {
      return NewsListWidget(newsList: searchResults);
    }
  }

  void _performSearch(String query) async {
    if (query.isNotEmpty) {
      // Use the searchNews method from your NewsService
      // to fetch search results based on the query.
      // Assuming you have implemented the searchNews method.
      List<Article> results = await newsService.searchNews(query);
      setState(() {
        searchResults = results;
      });
    } else {
      setState(() {
        searchResults.clear();
      });
    }
  }
}
