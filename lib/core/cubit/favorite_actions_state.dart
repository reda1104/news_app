part of 'favorite_actions_cubit.dart';

sealed class FavoriteActionsState {}

final class FavoriteActionsInitial extends FavoriteActionsState {}

final class FavoriteActionsLoading extends FavoriteActionsState {
  final String articleTitle;
  FavoriteActionsLoading(this.articleTitle);
}

final class FavoriteAdded extends FavoriteActionsState {
  final String articleTitle;
  FavoriteAdded(this.articleTitle);
}

final class FavoriteRemoved extends FavoriteActionsState {
  final String articleTitle;
  FavoriteRemoved(this.articleTitle);
}

final class FavoriteError extends FavoriteActionsState {
  final String errorMessage;
  FavoriteError(this.errorMessage);
}
