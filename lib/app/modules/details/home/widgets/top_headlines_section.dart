import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/app/modules/details/home/widgets/error_view.dart';
import '../controllers/home_controller.dart';
import 'top_headline_card.dart';

class TopHeadlinesSection extends GetView<HomeController> {
  const TopHeadlinesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Top Headlines',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.snackbar(
                    'Coming Soon',
                    'This feature is not implemented yet',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.grey[800],
                    colorText: Colors.white,
                    duration: const Duration(seconds: 2),
                    margin: const EdgeInsets.all(16),
                  );
                },
                child: const Text('See all'),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 300,
          child: Obx(() {
            if (controller.isLoadingTopHeadlines.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.hasErrorTopHeadlines.value) {
              return Center(
                child: ErrorView(
                  message: controller.errorMessageAllNews.value,
                  onRetry: controller.refreshNews,
                ),
              );
            }

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: controller.topHeadlines.length,
              itemBuilder: (context, index) {
                return TopHeadlineCard(
                  article: controller.topHeadlines[index],
                );
              },
            );
          }),
        ),
      ],
    );
  }
}
