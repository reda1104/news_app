import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/models/article_model.dart';
import 'package:news_app/core/utils/theme/app_colors.dart';
import 'package:news_app/core/views/widgets/app_bar_button.dart';
import 'package:news_app/core/models/news_api_response.dart';

class ArticleDetailsPage extends StatelessWidget {
  final Article article;
  const ArticleDetailsPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: article.urlToImage ?? '',
            width: double.infinity,
            height: size.height * 0.5,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Container(
            height: size.height * 0.5,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                colors: [
                  AppColors.black.withValues(alpha: 0.8),
                  AppColors.black.withValues(alpha: 0.2),
                ],
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.05,
            left: 16.0,
            right: 16.0,
            child: SizedBox(
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppBarButton(
                    iconData: Icons.arrow_back,
                    onPressed: () => Navigator.pop(context),
                  ),
                  Row(
                    children: [
                      AppBarButton(
                        iconData: Icons.favorite_border,
                        onPressed: () {},
                      ),
                      const SizedBox(width: 8.0),
                      AppBarButton(iconData: Icons.share, onPressed: () {}),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.31),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            article.source?.name ?? '',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        article.title ?? '',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "Trending . ${article.publishedAt?.toLocal().toString().split(' ')[0] ?? ''}",
                        style: Theme.of(context).textTheme.bodyMedium
                            ?.copyWith(color: AppColors.white),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 6.0),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24.0),
                        topRight: Radius.circular(24.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 16.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 20.0,
                                backgroundImage: CachedNetworkImageProvider(
                                  article.urlToImage ?? '',
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              SizedBox(
                                width: size.width * 0.8,
                                child: Row(
                                  children: [
                                    Text(
                                      maxLines: 1,
                                      article.author ?? 'Unknown Author',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    const SizedBox(width: 4.0),
                                    Icon(
                                      Icons.verified,
                                      color: AppColors.primaryColor,
                                      size: 16.0,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          Text(
                            (article.description ??
                                    'No description available') +
                                ("\n\n") +
                                (article.content ?? 'No content available'),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
