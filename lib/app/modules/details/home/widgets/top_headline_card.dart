import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/app/data/models/article_model.dart';
import 'package:news_app/app/modules/details/home/widgets/news_image_placeholder.dart';
import 'package:news_app/routes/app_pages.dart';

class TopHeadlineCard extends StatelessWidget {
  final Article article;

  const TopHeadlineCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        onTap: () => Get.toNamed(Routes.details, arguments: article),
        child: SizedBox(
          width: 280,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(4),
                ),
                child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: NewsImagePlaceholder(
                      imageUrl: article.urlToImage,
                    )),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        article.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      const Spacer(),
                      Text(
                        article.sourceName,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        article.publishedAt,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}