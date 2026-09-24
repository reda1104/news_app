import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/cubit/favorite_actions_cubit.dart';
import 'package:news_app/core/views/widgets/article_item_widget.dart';
import 'package:news_app/features/favorites/cubit/favorites_cubit.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesCubit = BlocProvider.of<FavoritesCubit>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.chevron_left),
        ),
        title: Text("Favorites"),
        centerTitle: true,
      ),
      body: BlocListener<FavoriteActionsCubit, FavoriteActionsState>(
        listener: (context, state) {
          if (state is FavoriteRemoved) {
            context.read<FavoritesCubit>().removeFavorite(state.articleTitle);
          }
        },
        child: BlocBuilder<FavoritesCubit, FavoritesState>(
          bloc: favoritesCubit,
          builder: (context, state) {
            if (state is FavoritesLoading) {
              return Center(child: CircularProgressIndicator.adaptive());
            }
            if (state is FavoritesLoaded) {
              final articles = state.articles;
              return ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 16),
                shrinkWrap: true,
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  return ArticleItemWidget(article: articles[index]);
                },
              );
            }
            if (state is FavoritesError) {
              return Center(child: Text('Error: ${state.errorMessage}'));
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
