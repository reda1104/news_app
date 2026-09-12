import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/features/home/models/top_headlines_api_response.dart';

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
        final publishedDate = article.publishedAt?.toLocal().toString().split(
          ' ',
        )[0];
        return Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                imageUrl: article.urlToImage ?? 'https://static.vecteezy.com/system/resources/previews/048/910/778/large_2x/default-image-missing-placeholder-free-vector.jpg',
                width: 170,
                height: 180,
                fit: BoxFit.cover,
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
                    style: Theme.of(context).textTheme.bodyLarge!
                        .copyWith(color: Colors.grey),
                  ),
                  SizedBox(height: 16),
                  Text(
                    article.title ?? '',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 8),
                  Text(
                    publishedDate ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
