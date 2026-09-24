import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/models/article_model.dart';
import 'package:news_app/core/utils/theme/app_colors.dart';
import 'package:news_app/core/models/news_api_response.dart';

class CustomCarouselSlider extends StatefulWidget {
  final List<Article> articles;
  const CustomCarouselSlider({super.key, required this.articles});

  @override
  State<CustomCarouselSlider> createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  final CarouselSliderController _controller = CarouselSliderController();
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = widget.articles.map((article) {
      final publishedDate = article.publishedAt?.toLocal().toString().split(
        ' ',
      )[0];
      return InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/article-details', arguments: article);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          child: Stack(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: article.urlToImage ?? '',
                fit: BoxFit.cover,
                width: 1000.0,
                height: 280.0,
                httpHeaders: const {
                  'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/120 Safari/537.36',
                  'Accept':
                      'image/avif,image/webp,image/apng,image/*,*/*;q=0.8',
                },
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.broken_image, size: 50),
              ),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(200, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 20.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${article.source?.name ?? ''} . ${publishedDate ?? ''}",
                        style: TextStyle(color: Colors.white, fontSize: 13.0),
                      ),
                      Text(
                        article.title ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
    return Column(
      children: [
        Expanded(
          child: CarouselSlider(
            items: imageSliders,
            carouselController: _controller,
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.articles.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: _current == entry.key ? 30.0 : 12.0,
                height: 12.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  borderRadius: _current == entry.key
                      ? BorderRadius.circular(8.0)
                      : null,
                  shape: _current == entry.key
                      ? BoxShape.rectangle
                      : BoxShape.circle,
                  color: _current == entry.key
                      ? AppColors.primaryColor
                      : AppColors.black.withOpacity(0.4),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
