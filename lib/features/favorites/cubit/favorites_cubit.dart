import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/cubit/favorite_actions_cubit.dart';
import 'package:news_app/core/models/article_model.dart';
import 'package:news_app/features/favorites/services/favorite_services.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitial());
  final favoriteActionsCubit = FavoriteActionsCubit();
  final favoriteServices = FavoriteServices();

  Future<void> getFavorites() async {
    emit(FavoritesLoading());
    try {
      final favArticles = await favoriteServices.getFavorites();
      for (int i = 0; i < favArticles.length; i++) {
        var article = favArticles[i];
        article = article.copyWith(isFavorite: true);
        favArticles[i] = article;
      }
      emit(FavoritesLoaded(favArticles));
    } catch (e) {
      emit(FavoritesError(errorMessage: e.toString()));
    }
  }

  Future<void> removeFavorite(String articleTitle) async {
    emit(FavoritesLoading());
    try {
      final favArticles = await favoriteServices.getFavorites();
      favArticles.removeWhere((element) => element.title == articleTitle);
      emit(FavoritesLoaded(favArticles));
    } catch (e) {
      emit(FavoritesError(errorMessage: e.toString()));
    }
  }
}
