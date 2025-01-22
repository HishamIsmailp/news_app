import 'dart:convert';
import '../models/article_model.dart';
import '../providers/api_provider.dart';

class NewsRepository {
  final ApiProvider apiProvider;

  NewsRepository({required this.apiProvider});

  String parseErrorMessage(String responseBody) {
    try {
      final Map<String, dynamic> errorData = json.decode(responseBody);

      if (errorData.containsKey('code') && errorData.containsKey('message')) {
        return '${errorData['code']}: ${errorData['message']}';
      }

      return 'Unknown error occurred';
    } catch (e) {
      return 'Failed to parse error response: $e';
    }
  }

  List<Article> parseArticles(List<dynamic> articlesData) {
    final articles = <Article>[];

    for (var article in articlesData) {
      try {
        articles.add(Article.fromJson(article));
      } catch (e) {
        continue;
      }
    }
    return articles;
  }

  Future<List<Article>> getTopHeadlines(int page) async {
    try {
      final response = await apiProvider.getTopHeadlines(page);
      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        if (data['articles'] == null || data['articles'].isEmpty) {
          return [];
        }
        return parseArticles(data['articles']);
      } else {
        throw Exception(parseErrorMessage(response.body));
      }
    } catch (e) {
      throw Exception('Failed to load top headlines: $e');
    }
  }

  Future<List<Article>> searchNews(String query, int page) async {
    try {
      final response = await apiProvider.searchNews(query, page);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['articles'] == null || data['articles'].isEmpty) {
          return [];
        }
        return parseArticles(data['articles']);
      } else {
        throw Exception(parseErrorMessage(response.body));
      }
    } catch (e) {
      throw Exception('Failed to search news: $e');
    }
  }
}
