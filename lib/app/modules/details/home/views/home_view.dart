import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../widgets/article_card.dart';
import '../widgets/search_bar.dart';
import '../widgets/error_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
      ),
      body: Column(
        children: [
          NewsSearchBar(
            onSearch: controller.searchNews,
          ),
          Expanded(
            child: Obx(
              () => RefreshIndicator(
                onRefresh: controller.refreshNews,
                child: controller.hasError.value
                    ? ErrorView(
                        message: controller.errorMessage.value,
                        onRetry: controller.refreshNews,
                      )
                    : _buildNewsList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsList() {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (!controller.hasReachedMax.value &&
            scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          if (controller.searchQuery.isEmpty) {
            controller.fetchTopHeadlines();
          } else {
            controller.searchNews(controller.searchQuery.value);
          }
        }
        return true;
      },
      child: ListView.builder(
        cacheExtent: 1000,
        addAutomaticKeepAlives: true,
        itemCount: controller.articles.length + 1,
        itemBuilder: (context, index) {
          if (index == controller.articles.length) {
            return Obx(() {
              if (controller.hasReachedMax.value) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      'No more articles available',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              }
              return controller.isLoading.value
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : const SizedBox.shrink();
            });
          }
          return ArticleCard(article: controller.articles[index]);
        },
      ),
    );
  }
}