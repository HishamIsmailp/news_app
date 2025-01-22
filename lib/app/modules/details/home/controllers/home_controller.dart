import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:news_app/app/data/models/article_model.dart';
import 'package:news_app/app/data/repositories/news_repository.dart';

class HomeController extends GetxController {
  final NewsRepository newsRepository;
  final scrollController = ScrollController();
  
  HomeController({required this.newsRepository});
  
  final topHeadlines = <Article>[].obs;
  final isLoadingTopHeadlines = false.obs;
  final hasErrorTopHeadlines = false.obs;
  final errorMessageTopHeadlines = ''.obs;
  
  final allNews = <Article>[].obs;
  final isLoadingAllNews = false.obs;
  final hasErrorAllNews = false.obs;
  final errorMessageAllNews = ''.obs;
  final hasReachedMaxAllNews = false.obs;
  final allNewsPage = 1.obs;
  
  final searchQuery = ''.obs;
  
  @override
  void onInit() {
    super.onInit();
    fetchTopHeadlines();
    fetchAllNews();
    setupScrollController();
  }

  void setupScrollController() {
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        fetchAllNews();
      }
    });
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
  
  Future<void> fetchTopHeadlines() async {
    try {
      isLoadingTopHeadlines.value = true;
      hasErrorTopHeadlines.value = false;
      final articles = await newsRepository.getTopHeadlines(1);
      topHeadlines.value = articles;
    } catch (e) {
      hasErrorTopHeadlines.value = true;
      errorMessageTopHeadlines.value = e.toString();
    } finally {
      isLoadingTopHeadlines.value = false;
    }
  }
  
  Future<void> fetchAllNews() async {
    if (isLoadingAllNews.value || hasReachedMaxAllNews.value) return;
    
    try {
      isLoadingAllNews.value = true;
      hasErrorAllNews.value = false;
      
      final newArticles = await newsRepository.searchNews(
        searchQuery.isEmpty ? 'news' : searchQuery.value,
        allNewsPage.value
      );
      
      if (newArticles.isEmpty) {
        hasReachedMaxAllNews.value = true;
        return;
      }
      
      if (allNewsPage.value == 1) {
        allNews.clear();
      }
      
      allNews.addAll(newArticles);
      allNewsPage.value++;
    } catch (e) {
      hasErrorAllNews.value = true;
      errorMessageAllNews.value = e.toString();
    } finally {
      isLoadingAllNews.value = false;
    }
  }
  
  Future<void> searchNews(String query) async {
    searchQuery.value = query;
    allNewsPage.value = 1;
    hasReachedMaxAllNews.value = false;
    await fetchAllNews();
  }
  
  Future<void> refreshNews() async {
    allNewsPage.value = 1;
    hasReachedMaxAllNews.value = false;
    await Future.wait([
      fetchTopHeadlines(),
      fetchAllNews(),
    ]);
  }
}