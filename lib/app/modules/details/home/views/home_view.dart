import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../widgets/article_card.dart';
import '../widgets/search_bar.dart';
import '../widgets/error_view.dart';
import '../widgets/top_headlines_section.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
      ),
      body: RefreshIndicator(
        onRefresh: controller.refreshNews,
        child: Column(
          children: [
            NewsSearchBar(
              onSearch: controller.searchNews,
            ),
            Expanded(
              child: ListView(
                controller: controller.scrollController,
                children: [
                  Obx(() => controller.searchQuery.isEmpty
                      ? const TopHeadlinesSection()
                      : const SizedBox.shrink()),

                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Obx(() => Text(
                      controller.searchQuery.isEmpty ? 'All News' : 'Search Results',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                  ),
                  
                  Obx(() {
                    if (controller.hasErrorAllNews.value) {
                      return ErrorView(
                        message: controller.errorMessageAllNews.value,
                        onRetry: controller.refreshNews,
                      );
                    }

                    return Column(
                      children: [
                        ...controller.allNews.map((article) => ArticleCard(
                          article: article,
                        )),
                        
                        if (controller.hasReachedMaxAllNews.value)
                          const Padding(
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
                          )
                        else if (controller.isLoadingAllNews.value)
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}