import 'package:news_app/core/models/article_model.dart';
import 'package:news_app/core/services/local_database_hive.dart';
import 'package:news_app/core/utils/app_constants.dart';

class FavoriteServices {
  final localDatabaseHive = LocalDatabaseHive();
  Future<List<Article>> getFavorites() async {
    final favorites = await localDatabaseHive.getData(
      AppConstants.localDatabaseBox,
    );

    if (favorites == null) {
      return [];
    }

    return (favorites as List).cast<Article>();
  }
}
