import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../controllers/details_controller.dart';

class DetailsView extends GetView<DetailsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Article Details'),
      ),
      body: Obx(
        () => controller.article.value == null
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (controller.article.value?.urlToImage != null)
                      CachedNetworkImage(
                        imageUrl: controller.article.value!.urlToImage!,
                        height: 250,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          height: 250,
                          color: Colors.grey[300],
                          child: Center(child: CircularProgressIndicator()),
                        ),
                        errorWidget: (context, url, error) => Container(
                          height: 250,
                          color: Colors.grey[300],
                          child: Icon(Icons.error),
                        ),
                      ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.article.value!.title,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Icon(Icons.newspaper, size: 16),
                              SizedBox(width: 4),
                              Text(
                                controller.article.value!.sourceName,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.calendar_today, size: 16),
                              SizedBox(width: 4),
                              Text(
                                controller.article.value!.publishedAt,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          if (controller.article.value?.author != null) ...[
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.person, size: 16),
                                SizedBox(width: 4),
                                Text(
                                  'By ${controller.article.value!.author}',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ],
                          SizedBox(height: 24),
                          Text(
                            controller.article.value!.description,
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.5,
                            ),
                          ),
                          if (controller.article.value?.content != null) ...[
                            SizedBox(height: 16),
                            Text(
                              controller.article.value!.content!,
                              style: TextStyle(
                                fontSize: 16,
                                height: 1.5,
                              ),
                            ),
                          ],
                          SizedBox(height: 24),
                          if (controller.article.value?.url != null)
                            Center(
                              child: ElevatedButton.icon(
                                onPressed: controller.openArticleUrl,
                                icon: Icon(Icons.launch),
                                label: Text('Read Full Article'),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
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