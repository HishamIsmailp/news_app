import 'package:get/get.dart';
import 'package:news_app/app/data/providers/api_provider.dart';
import 'package:news_app/app/data/repositories/news_repository.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiProvider());
    Get.lazyPut(() => NewsRepository(apiProvider: Get.find<ApiProvider>()));
    Get.lazyPut(() => HomeController(newsRepository: Get.find<NewsRepository>()));
  }
}