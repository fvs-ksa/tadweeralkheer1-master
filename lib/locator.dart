import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:tadweer_alkheer/providers/donation_points_provider.dart';
import 'package:tadweer_alkheer/providers/gallery_image_provider.dart';
import 'package:tadweer_alkheer/providers/gallery_video_provider.dart';
import 'package:tadweer_alkheer/providers/issue_provider.dart';
import 'package:tadweer_alkheer/providers/map_provider.dart';
import 'package:tadweer_alkheer/providers/partners_provider.dart';
import 'package:tadweer_alkheer/providers/review_provider.dart';
import 'package:tadweer_alkheer/screens/map_screen.dart';
import './providers/tasks_provider.dart';
import './providers/donations_provider.dart';
import './services/crud_model.dart';
import './providers/users_provider.dart';
import './providers/categories_provider.dart';
import 'providers/donation_points_provider.dart';
import 'providers/gallery_image_provider.dart';
import 'providers/gallery_video_provider.dart';
import 'providers/partners_provider.dart';

GetIt locator = GetIt.instance;
var fcmToken='';
void setupLocator() {
  locator.registerFactory(() => CRUDModel());
  locator.registerLazySingleton(() => UsersProvider());
  locator.registerLazySingleton(() => DonationsProvider());
  locator.registerLazySingleton(() => IssueProvider());
  locator.registerLazySingleton(() => CategoriesProvider());
  locator.registerLazySingleton(() => TasksProvider());
  locator.registerLazySingleton(() => MapProvider());
  locator.registerLazySingleton(() => DonationPointsProvider());
  locator.registerLazySingleton(() => GalleryImagesProvider());
  locator.registerLazySingleton(() => GalleryVideosProvider());
  locator.registerLazySingleton(() => PartnersProvider());
  locator.registerLazySingleton(() => ReviewsProvider());
  locator.registerLazySingleton(() => RatingProvider());
  locator.registerLazySingleton(() =>  TODonationPointsProvider());
  locator.registerLazySingleton(() => MapScreen());
}
class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
  new GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState.pushNamed(routeName);
  }
}