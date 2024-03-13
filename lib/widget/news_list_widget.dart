import 'package:flutter/material.dart';
import 'package:news_pulse/models/news_model.dart';
import 'package:news_pulse/screens/news_details_screen.dart';

class NewsListWidget extends StatelessWidget {
  final List<Article> newsList;

  NewsListWidget({required this.newsList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: newsList.length,
      itemBuilder: (context, index) {
        String title = newsList[index].title ?? '';
        String publishedAt = newsList[index].publishedAt ?? '';
        String imageUrl = newsList[index].urlToImage ?? '';

        return ListTile(
          contentPadding: EdgeInsets.all(16.0),
          leading: Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: imageUrl.isNotEmpty
                    ? NetworkImage(imageUrl) as ImageProvider<Object>
                    : AssetImage('assets/news.jpg') as ImageProvider<Object>,
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 8.0),
              Text(
                publishedAt,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    NewsDetailScreen(article: newsList[index]),
              ),
            );
          },
        );
      },
    );
  }
}
