import 'dart:convert';
import '../models/article_model.dart';
import '../providers/api_provider.dart';

class NewsRepository {
  final ApiProvider apiProvider;

  NewsRepository({required this.apiProvider});

   Future<List<Article>> getTopHeadlines(int page) async {
    try {
      final response = await apiProvider.getTopHeadlines(page);
      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        if (data['articles'] == null || data['articles'].isEmpty) {
          return [];
        }
        final articles = <Article>[];
        for (var article in data['articles']) {
          try {
            articles.add(Article.fromJson(article));
          } catch (e) {
            continue;
          }
        }
        return articles;
      } else {
        if (data['code'] == 'maximumResultsReached') {
          throw Exception('maximumResultsReached');
        }
        throw Exception('Failed to load news: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load news: $e');
    }
  }

  Future<List<Article>> searchNews(String query, int page) async {
    try {
      final response = await apiProvider.searchNews(query, page);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final articles = <Article>[];
        
        for (var article in data['articles']) {
          try {
            articles.add(Article.fromJson(article));
          } catch (e) {
            continue;
          }
        }
        
        return articles;
      } else {
        throw Exception('Failed to search news: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to search news: $e');
    }
  }
}
