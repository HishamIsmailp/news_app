import 'package:intl/intl.dart';

class Article {
  final String title;
  final String description;
  final String? url;
  final String? urlToImage;
  final String publishedAt;
  final String? content;
  final String sourceName;
  final String? author;

  Article({
    required this.title,
    required this.description,
    this.url,
    this.urlToImage,
    required this.publishedAt,
    this.content,
    required this.sourceName,
    this.author,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    if (json['title'] == '[Removed]' || 
        json['description'] == '[Removed]' || 
        json['content'] == '[Removed]') {
      throw FormatException('Removed article');
    }

    return Article(
      title: json['title'] ?? 'No title available',
      description: json['description'] ?? 'No description available',
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: _formatDate(json['publishedAt'] ?? ''),
      content: json['content'],
      sourceName: json['source']['name'] ?? 'Unknown source',
      author: json['author'],
    );
  }

  static String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      final formatter = DateFormat('MMM dd, yyyy');
      return formatter.format(date);
    } catch (e) {
      return 'Date unavailable';
    }
  }
}
