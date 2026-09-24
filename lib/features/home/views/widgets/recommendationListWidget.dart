import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/cubit/favorite_actions_cubit.dart';
import 'package:news_app/core/models/article_model.dart';
import 'package:news_app/core/utils/route/app_routes.dart';
import 'package:news_app/core/models/news_api_response.dart';
import 'package:news_app/core/views/widgets/article_item_widget.dart';

class Recommendationlistwidget extends StatelessWidget {
  final List<Article> articles;
  const Recommendationlistwidget({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(height: 16),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];
        return BlocProvider(
          create: (context) => FavoriteActionsCubit(),
          child: ArticleItemWidget(article: article),
        );
      },
    );
  }
}
