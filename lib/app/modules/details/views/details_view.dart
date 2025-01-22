import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/app/core/utils/responsive_helper.dart';
import 'package:news_app/app/modules/details/home/widgets/news_image_placeholder.dart';
import '../controllers/details_controller.dart';

class DetailsView extends GetView<DetailsController> {
  const DetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Article Details'),
      ),
      body: Obx(
        () => controller.article.value == null
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NewsImagePlaceholder(
                        imageUrl: controller.article.value?.urlToImage,
                        width: double.infinity,
                        height: ResponsiveHelper.screenHeight(context) * 0.3,
                        fit: BoxFit.cover),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.article.value!.title,
                            style: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                              height: ResponsiveHelper.screenHeight(context) *
                                  0.02),
                          Row(
                            children: [
                              const Icon(Icons.newspaper, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                controller.article.value!.sourceName,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.calendar_today, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                controller.article.value!.publishedAt,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          if (controller.article.value?.author != null) ...[
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.person, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  'By ${controller.article.value!.author}',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ],
                          SizedBox(
                              height: ResponsiveHelper.screenHeight(context) *
                                  0.02),
                          Text(
                            controller.article.value!.description,
                            style: GoogleFonts.acme(
                              fontSize: 15,
                              height: 1.5,
                            ),
                          ),
                          if (controller.article.value?.content != null) ...[
                            const SizedBox(height: 16),
                            Text(
                              controller.article.value!.content!,
                              style: GoogleFonts.acme(
                                fontSize: 15,
                                height: 1.5,
                              ),
                            ),
                          ],
                          const SizedBox(height: 24),
                          if (controller.article.value?.url != null)
                            Center(
                              child: ElevatedButton.icon(
                                onPressed: controller.openArticleUrl,
                                icon: const Icon(Icons.launch),
                                label: const Text('Read Full Article'),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 12,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
