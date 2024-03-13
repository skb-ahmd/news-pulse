import 'dart:convert'; // Add this import statement
import 'package:flutter/material.dart';
import 'package:news_pulse/models/news_model.dart';
import 'package:news_pulse/widget/news_list_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedScreen extends StatefulWidget {
  @override
  _SavedScreenState createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  List<Article> savedArticles = [];

  @override
  void initState() {
    super.initState();
    setState(() {});
    _loadSavedArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved News'),
      ),
      body: _buildSavedArticles(),
    );
  }

  Widget _buildSavedArticles() {
    if (savedArticles.isEmpty) {
      return Center(
        child: Text('No saved articles'),
      );
    } else {
      return NewsListWidget(newsList: savedArticles);
    }
  }

  Future<void> _loadSavedArticles() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedArticleKeys =
        prefs.getKeys().where((key) => key.startsWith('article_')).toList();

    setState(() {
      savedArticles = savedArticleKeys.map((key) {
        String articleJson = prefs.getString(key)!;
        Map<String, dynamic> articleMap = jsonDecode(articleJson);
        return Article.fromJson(articleMap);
      }).toList();
    });
  }
}
