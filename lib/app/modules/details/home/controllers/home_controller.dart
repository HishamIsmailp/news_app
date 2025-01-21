import 'package:get/get.dart';
import 'package:news_app/app/data/models/article_model.dart';
import 'package:news_app/app/data/repositories/news_repository.dart';

class HomeController extends GetxController {
 final NewsRepository newsRepository;
 final hasReachedMax = false.obs;
  
  HomeController({required this.newsRepository});

  final articles = <Article>[].obs;
  final isLoading = false.obs;
  final hasError = false.obs;
  final errorMessage = ''.obs;
  final page = 1.obs;
  final searchQuery = ''.obs;
  final refreshController = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    fetchTopHeadlines();
  }

  Future<void> fetchTopHeadlines() async {
    if (isLoading.value || hasReachedMax.value) return;
    
    try {
      isLoading.value = true;
      hasError.value = false;
      final newArticles = await newsRepository.getTopHeadlines(page.value);
      
      if (newArticles.isEmpty) {
        hasReachedMax.value = true;
        return;
      }
      
      if (page.value == 1) {
        articles.clear();
      }
      articles.addAll(newArticles);
      page.value++;
    } catch (e) {
      hasError.value = true;
      if (e.toString().contains('maximumResultsReached')) {
        hasReachedMax.value = true;
        errorMessage.value = 'You have reached the maximum number of results available.';
      } else {
        errorMessage.value = e.toString();
      }
    } finally {
      isLoading.value = false;
      refreshController.value = false;
    }
  }

  Future<void> searchNews(String query) async {
    if (query.isEmpty) {
      page.value = 1;
      await fetchTopHeadlines();
      return;
    }

    try {
      isLoading.value = true;
      hasError.value = false;
      searchQuery.value = query;
      page.value = 1;
      articles.clear();
      
      final newArticles = await newsRepository.searchNews(query, page.value);
      articles.addAll(newArticles);
      page.value++;
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshNews() async {
    page.value = 1;
    if (searchQuery.isEmpty) {
      await fetchTopHeadlines();
    } else {
      await searchNews(searchQuery.value);
    }
  }
}