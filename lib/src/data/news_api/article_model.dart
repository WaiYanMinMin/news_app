import 'dart:convert';

class Article {
  String? title;
  String? author;
  String? description;
  String? urlToImage;
  String? publishedAt;
  String? content;
  String? articleUrl;

  Article(
      {required this.title,
      required this.description,
      required this.author,
      required this.content,
      required this.publishedAt,
      required this.urlToImage,
      required this.articleUrl});

  factory Article.fromJson(Map<String, dynamic> jsonData) {
    return Article(
      title: jsonData['title'],
      description: jsonData['description'],
      content: jsonData['content'],
      author: jsonData['author'],
      publishedAt: jsonData['publishedAt'],
      urlToImage: jsonData['urlToImage'],
      articleUrl: jsonData['articleUrl'],
    );
  }

  static Map<String, dynamic> toMap(Article article) => {
        'title': article.title,
        'rating': article.description,
        'content': article.content,
        'author': article.author,
        'publishedAt': article.publishedAt,
        'urlToImage': article.urlToImage,
        'articleUrl': article.articleUrl,
      };

  static String encode(List<Article> article) => json.encode(
        article
            .map<Map<String, dynamic>>((article) => Article.toMap(article))
            .toList(),
      );

  static List<Article> decode(String article) =>
      (json.decode(article) as List<dynamic>)
          .map<Article>((item) => Article.fromJson(item))
          .toList();
}
