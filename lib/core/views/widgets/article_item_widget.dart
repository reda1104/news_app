import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/models/news_api_response.dart';
import 'package:news_app/core/utils/route/app_routes.dart';

class ArticleItemWidget extends StatelessWidget {
  final Article article;
  const ArticleItemWidget({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final publishedDate = article.publishedAt?.toLocal().toString().split(
      ' ',
    )[0];
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(AppRoutes.articleDetails, arguments: article);
      },
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: CachedNetworkImage(
              imageUrl:
                  article.urlToImage != null && article.urlToImage!.isNotEmpty
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
