import 'package:flutter/material.dart';
import 'package:news_pulse/screens/home_screen.dart';
import 'package:news_pulse/service/news_service.dart';

void main() {
	runApp(MyApp());
}

class MyApp extends StatelessWidget {
	final NewsService newsService = NewsService();
	MyApp({super.key});

	// This widget is the root of your application.
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Flutter Demo',
			darkTheme: ThemeData(
				brightness: Brightness.light,
				// colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
				useMaterial3: true,
			),
			themeMode: ThemeMode.dark,
			theme: ThemeData(
				colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
				useMaterial3: true,
			),
			home: HomeScreen());
	}
}
