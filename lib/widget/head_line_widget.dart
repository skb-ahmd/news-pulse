import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:news_pulse/models/news_model.dart';
import 'package:intl/intl.dart';
import 'package:news_pulse/screens/news_details_screen.dart';

class HeadlinesCarousel extends StatelessWidget {
  final List<Article> headlines;

  HeadlinesCarousel({required this.headlines});

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width * 0.8;

    return CarouselSlider(
      items: headlines.map((article) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsDetailScreen(article: article),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16.0),
                  bottom: Radius.circular(16.0),
                ),
                child: Card(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16.0),
                            bottom: Radius.circular(16.0),
                          ),
                          child: Container(
                            height: cardWidth * 1.8,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: article.urlToImage.isNotEmpty
                                    ? NetworkImage(article.urlToImage)
                                    : AssetImage('assets/news.jpg')
                                        as ImageProvider<Object>,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                              Colors.black.withOpacity(0.9),
                              Colors.black,
                            ],
                          ),
                        ),
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              article.title ?? '',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${article.author.isNotEmpty ? article.author : "Unknown"}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          color: Colors.white,
                                          fontStyle: FontStyle.italic),
                                ),
                                Text(
                                  'Posted: ${formatDate(article.publishedAt)}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
      options: CarouselOptions(
        height: cardWidth * 1.8,
        viewportFraction: 0.9,
        enlargeCenterPage: true,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 5),
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
      int daysAgo = now.difference(date).inDays;
      return '$daysAgo ${daysAgo == 1 ? 'day' : 'days'} ago';
    }
  }
}
