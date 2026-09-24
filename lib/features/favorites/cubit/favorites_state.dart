part of 'favorites_cubit.dart';

sealed class FavoritesState {}

final class FavoritesInitial extends FavoritesState {}

final class FavoritesLoading extends FavoritesState {}

final class FavoritesLoaded extends FavoritesState {
  final List<Article> articles;
  FavoritesLoaded(this.articles);
}

final class FavoritesError extends FavoritesState {
  final String errorMessage;
  FavoritesError({required this.errorMessage});
}
