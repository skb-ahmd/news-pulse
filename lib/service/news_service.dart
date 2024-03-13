import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_pulse/models/news_model.dart';

class NewsService {
  final String apiKey;
  final String baseUrl;

  NewsService({
    this.apiKey = '52e5e6efed2f4d7384b9a61c6c201258',
    this.baseUrl = "https://newsapi.org/v2",
  });

  Future<Map<String, dynamic>> _getResponse(String endpoint) async {
    final response =
        await http.get(Uri.parse('$baseUrl$endpoint&apiKey=$apiKey'));
    print(response.body);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<Article>> getTopHeadlines({String language = 'en'}) async {
    try {
      final response = await _getResponse('/top-headlines?language=$language');
      print(response);
      return (response['articles'] as List<dynamic>)
          .map((article) => Article.fromJson(article))
          .toList();
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }

  Future<List<Article>> getCategoryNews(String category,
      {String language = 'en'}) async {
    try {
      final response = await _getResponse(
          '/top-headlines?category=$category&language=$language');
      return (response['articles'] as List<dynamic>)
          .map((article) => Article.fromJson(article))
          .toList();
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }

  Future<List<Article>> searchNews(String query) async {
    try {
      final response = await _getResponse('/everything?q=$query');
      return (response['articles'] as List<dynamic>)
          .map((article) => Article.fromJson(article))
          .toList();
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }
}
