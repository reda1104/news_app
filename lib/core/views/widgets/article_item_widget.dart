import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/cubit/favorite_actions_cubit.dart';
import 'package:news_app/core/models/article_model.dart';
import 'package:news_app/core/models/news_api_response.dart';
import 'package:news_app/core/utils/route/app_routes.dart';
import 'package:news_app/core/utils/theme/app_colors.dart';

class ArticleItemWidget extends StatelessWidget {
  final Article article;
  const ArticleItemWidget({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final publishedDate = article.publishedAt?.toLocal().toString().split(
      ' ',
    )[0];
    final favoriteActionCubit = BlocProvider.of<FavoriteActionsCubit>(context);
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(AppRoutes.articleDetails, arguments: article);
      },
      child: Row(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: CachedNetworkImage(
                  imageUrl:
                      article.urlToImage != null &&
                          article.urlToImage!.isNotEmpty
                      ? article.urlToImage!
                      : 'https://static.vecteezy.com/system/resources/previews/048/910/778/large_2x/default-image-missing-placeholder-free-vector.jpg',
                  width: 170,
                  height: 180,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Image.network(
                    'https://static.vecteezy.com/system/resources/previews/048/910/778/large_2x/default-image-missing-placeholder-free-vector.jpg',
                    width: 170,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              PositionedDirectional(
                top: 8,
                end: 8,
                child: BlocBuilder<FavoriteActionsCubit, FavoriteActionsState>(
                  bloc: favoriteActionCubit,
                  buildWhen: (previous, current) {
                    if (current is FavoriteActionsLoading) {
                      return current.articleTitle == article.title;
                    }

                    if (current is FavoriteAdded) {
                      return current.articleTitle == article.title;
                    }

                    if (current is FavoriteRemoved) {
                      return current.articleTitle == article.title;
                    }

                    return false;
                  },
                  builder: (context, state) {
                    final isLoading =
                        state is FavoriteActionsLoading &&
                        state.articleTitle == article.title;

                    final isAdded =
                        state is FavoriteAdded &&
                        state.articleTitle == article.title;

                    final isRemoved =
                        state is FavoriteRemoved &&
                        state.articleTitle == article.title;

                    if (isLoading) {
                      return const CircularProgressIndicator.adaptive();
                    }

                    bool isFavorite = article.isFavorite;

                    if (isAdded) {
                      isFavorite = true;
                    } else if (isRemoved) {
                      isFavorite = false;
                    }

                    return InkWell(
                      onTap: () async {
                        await favoriteActionCubit.setFavorite(article);
                      },
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            isFavorite
                                ? Icons.favorite_rounded
                                : Icons.favorite_border,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  article.source?.name ?? '',
                  style: Theme.of(context).textTheme.titleMedium!
                      .copyWith(color: Colors.grey),
                ),
                SizedBox(height: 16),
                Text(
                  article.title ?? '',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  publishedDate ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge!,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
