import 'package:flutter/material.dart';
import 'package:news_pulse/models/news_model.dart';
import 'package:news_pulse/service/news_service.dart';
import 'package:news_pulse/widget/news_list_widget.dart';

class CategoryNewsScreen extends StatefulWidget {
  final NewsService newsService;
  final String category;

  CategoryNewsScreen({required this.newsService, required this.category});

  @override
  _CategoryNewsScreenState createState() => _CategoryNewsScreenState();
}

class _CategoryNewsScreenState extends State<CategoryNewsScreen> {
  late Future<List<Article>> _categoryNews;

  @override
  void initState() {
    super.initState();
    _categoryNews = widget.newsService.getCategoryNews(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category} News'),
      ),
      body: FutureBuilder<List<Article>>(
        future: _categoryNews,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final categoryNews = snapshot.data!;
            return NewsListWidget(newsList: categoryNews);
          }
        },
      ),
    );
  }
}
