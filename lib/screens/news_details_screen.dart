import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_pulse/models/news_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_share/flutter_share.dart'; // Add this import

class NewsDetailScreen extends StatefulWidget {
  final Article article;

  NewsDetailScreen({required this.article});

  @override
  _NewsDetailScreenState createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  bool isNewsSaved = false;

  @override
  void initState() {
    super.initState();
    checkIfNewsIsSaved(widget.article);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Detail'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                height: 200.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: widget.article.urlToImage.isNotEmpty
                        ? NetworkImage(widget.article.urlToImage)
                        : AssetImage('assets/news.jpg')
                            as ImageProvider<Object>,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              widget.article.title ?? '',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              widget.article.content ?? '',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Author: ${widget.article.author.isNotEmpty ? widget.article.author : "Unknown"}',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Posted: ${formatDate(widget.article.publishedAt)}',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    saveOrUnsaveNews(widget.article);
                  },
                  icon: Icon(
                    isNewsSaved ? Icons.bookmark : Icons.bookmark_outline,
                    color: Colors.grey,
                    size: 30.0,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {
                    shareArticle(widget.article);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateTime now = DateTime.now();

    if (now.difference(date).inHours < 24) {
      int hoursAgo = now.difference(date).inHours;
      return '$hoursAgo ${hoursAgo == 1 ? 'hour' : 'hours'} ago';
    } else {
      return DateFormat('MMM d, y').format(date);
    }
  }

  Future<void> checkIfNewsIsSaved(Article article) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedArticleJson = prefs.getString(article.url);

    setState(() {
      isNewsSaved = savedArticleJson != null;
    });
  }

  Future<void> saveOrUnsaveNews(Article article) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (isNewsSaved) {
      // If the news is already saved, remove it from saved news
      prefs.remove(article.url);
    } else {
      // If the news is not saved, add it to saved news
      String articleJson = jsonEncode(article.toJson());
      prefs.setString('article_${article.url}', articleJson);
    }

    // Update the state to reflect the new save status
    setState(() {
      isNewsSaved = !isNewsSaved;
    });
  }

  Future<void> shareArticle(Article article) async {
    await FlutterShare.share(
      title: 'Check out this news article!',
      text:
          'Check out this news article! I found on NewsPulse \n\n${article.title}\n\n ${article.url}',
    );
  }
}
