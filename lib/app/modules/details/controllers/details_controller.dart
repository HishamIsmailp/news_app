import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/models/article_model.dart';

class DetailsController extends GetxController {
  final article = Rx<Article?>(null);

  @override
  void onInit() {
    super.onInit();
    article.value = Get.arguments as Article;
  }

  Future<void> openArticleUrl() async {
    if (article.value?.url != null) {
      final url = Uri.parse(article.value!.url!);
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        Get.snackbar(
          'Error',
          'Could not open the article URL',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }
}