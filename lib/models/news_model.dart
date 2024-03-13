class NewsResponse {
	String status;
	int totalResults;
	List<Article> articles;

	NewsResponse({
		required this.status,
		required this.totalResults,
		required this.articles,
	});

	factory NewsResponse.fromJson(Map<String, dynamic> json) {
		return NewsResponse(
			status: json['status'],
			totalResults: json['totalResults'],
			articles: List<Article>.from(
				json['articles'].map((article) => Article.fromJson(article)),
			),
		);
	}
}

class Article {
	Source source;
	String author;
	String title;
	String description;
	String url;
	String urlToImage;
	String publishedAt;
	String content;

	Article({
		required this.source,
		required this.author,
		required this.title,
		required this.description,
		required this.url,
		required this.urlToImage,
		required this.publishedAt,
		required this.content,
	});
	Map<String, dynamic> toJson() {
		return {
			'source': source.toJson(),
			'author': author,
			'title': title,
			'description': description,
			'url': url,
			'urlToImage': urlToImage,
			'publishedAt': publishedAt,
			'content': content,
		};
	}

	factory Article.fromJson(Map<String, dynamic> json) {
		return Article(
			source: Source.fromJson(json['source']),
			author: json['author'] ?? "",
			title: json['title'] ?? "",
			description: json['description'] ?? "",
			url: json['url'] ?? "",
			urlToImage: json['urlToImage'] ?? "",
			publishedAt: json['publishedAt'] ?? "",
			content: json['content'] ?? "",
		);
	}
}

class Source {
	String? id;
	String name;

	Source({
		required this.id,
		required this.name,
	});

	Map<String, dynamic> toJson() {
		return {
			'id': id,
			'name': name,
		};
	}

	factory Source.fromJson(Map<String, dynamic> json) {
		return Source(
			id: json['id'],
			name: json['name'],
		);
	}
}
