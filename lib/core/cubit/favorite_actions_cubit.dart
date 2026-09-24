import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/models/article_model.dart';
import 'package:news_app/core/models/news_api_response.dart';
import 'package:news_app/core/services/local_database_hive.dart';
import 'package:news_app/core/utils/app_constants.dart';

part 'favorite_actions_state.dart';

class FavoriteActionsCubit extends Cubit<FavoriteActionsState> {
  FavoriteActionsCubit._internal() : super(FavoriteActionsInitial());

  static final FavoriteActionsCubit _instance =
      FavoriteActionsCubit._internal();

  factory FavoriteActionsCubit() => _instance;

  final localDatabaseHive = LocalDatabaseHive();

  Future<void> setFavorite(Article article) async {
    final title = article.title ?? '';

    emit(FavoriteActionsLoading(title));
    print('LOADING: $title');

    try {
      final favArticles = await _getFavorite();
      print('FAVORITES: ${favArticles.length}');

      final isFavorite = favArticles.any(
        (element) => element.title == article.title,
      );

      print('IS FAVORITE: $isFavorite');

      if (isFavorite) {
        favArticles.removeWhere((element) => element.title == article.title);
      } else {
        favArticles.add(article.copyWith(isFavorite: true));
      }

      print('BEFORE SAVE');

      await localDatabaseHive.saveData(
        AppConstants.localDatabaseBox,
        favArticles,
      );

      print('AFTER SAVE');

      if (isFavorite) {
        emit(FavoriteRemoved(title));
        print('REMOVED');
      } else {
        emit(FavoriteAdded(title));
        print('ADDED');
      }
    } catch (e) {
      print('ERROR: $e');
      emit(FavoriteError(e.toString()));
    }
  }

  // Future<void> setFavorite(Article article) async {
  //   emit(FavoriteActionsLoading( article.title ?? ''));
  //   final favArticles = _getFavorite();
  //   try {
  //     await localDatabaseHive.saveData(
  //       AppConstants.localDatabaseBox,
  //       favArticles,
  //     );
  //     emit(FavoriteAdded(article.title ?? ''));
  //   } catch (e) {
  //     emit(FavoriteError(e.toString()));
  //   }
  // }

  // Future<void> removeFavorite(Article article) async {
  //   emit(FavoriteActionsLoading(article.title ?? ''));
  //   try {
  //     await localDatabaseHive.deleteData(AppConstants.localDatabaseBox);
  //     emit(FavoriteRemoved(article.title ?? ''));
  //   } catch (e) {
  //     emit(FavoriteError(e.toString()));
  //   }
  // }

  Future<List<Article>> _getFavorite() async {
    final favorites = await localDatabaseHive.getData(
      AppConstants.localDatabaseBox,
    );

    if (favorites == null) {
      return [];
    }

    return (favorites as List).cast<Article>();
  }
}
