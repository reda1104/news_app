import 'package:hive_flutter/adapters.dart';
import 'package:news_app/core/models/article_model.dart';
import 'package:news_app/core/utils/app_constants.dart';

class LocalDatabaseHive {
  static Future<void> initHive() async {
    await Hive.initFlutter();

    Hive.registerAdapter(ArticleAdapter());
    Hive.registerAdapter(SourceAdapter());
  }

  Future<void> saveData<T>(String key, T value) async {
    final box = await Hive.openBox(AppConstants.localDatabaseBox);
    await box.put(key, value);
  }

  Future<dynamic> getData(String key) async {
    final box = await Hive.openBox(AppConstants.localDatabaseBox);
    return box.get(key);
  }

  Future<void> deleteData(String key) async {
    final box = await Hive.openBox(AppConstants.localDatabaseBox);
    await box.delete(key);
  }
}
