import 'package:flutter/material.dart';
import 'package:news_pulse/models/news_model.dart';
import 'package:news_pulse/screens/category_news_screen.dart';
import 'package:news_pulse/screens/news_details_screen.dart';
import 'package:news_pulse/screens/saved_screen.dart';
import 'package:news_pulse/screens/search_screen.dart';
import 'package:news_pulse/service/news_service.dart';
import 'package:news_pulse/widget/category_tags_widget.dart';
import 'package:news_pulse/widget/head_line_widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Article>> _topHeadlines;
  String selectedCategory = 'All';

  var newsService = NewsService();

  @override
  void initState() {
    super.initState();
    _topHeadlines = newsService.getTopHeadlines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SavedScreen()),
              );
            },
            icon: Icon(Icons.bookmark)),
        centerTitle: true,
        title: Text('Hot Topics'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchScreen()),
                );
              },
              icon: Icon(Icons.search))
        ],
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
                  CategoryTagsWidget(
                    categories: [
                      'All',
                      'Business',
                      'Entertainment',
                      'General',
                      'Health',
                      'Science',
                      'Sports',
                      'Technology',
                    ],
                    onCategorySelected: (category) {
                      if (category != 'All') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryNewsScreen(
                              newsService: newsService,
                              category: category,
                            ),
                          ),
                        );
                      } else {
                        setState(() {
                          selectedCategory = category;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: _buildTopHeadlines(),
          ),
        ],
      ),
    );
  }

  Widget _buildTopHeadlines() {
    return FutureBuilder<List<Article>>(
      future: _topHeadlines,
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
          final headlines = snapshot.data!;
          return HeadlinesCarousel(headlines: headlines);
        }
      },
    );
  }
}
