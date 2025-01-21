import 'package:http/http.dart' as http;
import '../../core/values/constants.dart';

class ApiProvider {
  Future<http.Response> getTopHeadlines(int page) async {
    return await http.get(
      Uri.parse('${Constants.baseUrl}/top-headlines?country=us&page=$page&apiKey=${Constants.apiKey}'),
    );
  }

  Future<http.Response> searchNews(String query, int page) async {
    return await http.get(
      Uri.parse('${Constants.baseUrl}/everything?q=$query&page=$page&apiKey=${Constants.apiKey}'),
    );
  }
}
