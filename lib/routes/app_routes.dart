import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:news_app/app/modules/details/bindings/details_binding.dart';
import 'package:news_app/app/modules/details/home/bindings/home_binding.dart';
import 'package:news_app/app/modules/details/home/views/home_view.dart';
import 'package:news_app/app/modules/details/views/details_view.dart';
import 'package:news_app/routes/app_pages.dart';

class AppPages {
  static const initial = Routes.home;

  static final routes = [
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.details,
      page: () => const DetailsView(),
      binding: DetailsBinding(),
    ),
  ];
}