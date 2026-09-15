import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/utils/theme/app_colors.dart';
import 'package:news_app/core/views/widgets/app_bar_button.dart';
import 'package:news_app/core/views/widgets/app_drawer.dart';
import 'package:news_app/features/home/cubit/home_cubit.dart';
import 'package:news_app/features/home/views/widgets/custom_carousel_slider.dart';
import 'package:news_app/features/home/views/widgets/recommendationListWidget.dart';
import 'package:news_app/features/home/views/widgets/title_headline_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final homeCubit = HomeCubit();
        homeCubit.getTopHeadlines();
        homeCubit.getRecommendedArticles();
        return homeCubit;
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppBarButton(
              iconData: Icons.menu,
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              },
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppBarButton(
                iconData: Icons.search,
                onPressed: () {
                  // Handle search button press
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppBarButton(
                iconData: Icons.notifications,
                onPressed: () {
                  // Handle notifications button press
                },
              ),
            ),
          ],
        ),
        drawer: AppDrawer(),
        body: Builder(
          builder: (context) {
            final homeCubit = BlocProvider.of<HomeCubit>(context);
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [
                    TitleHeadlineWidget(title: "Breaking News", onTap: () {}),
                    SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: BlocBuilder<HomeCubit, HomeState>(
                        bloc: homeCubit,
                        buildWhen: (previous, current) =>
                            current is TopHeadlinesLoading ||
                            current is TopHeadlinesLoaded ||
                            current is TopHeadlinesError,
                        builder: (context, state) {
                          if (state is TopHeadlinesLoading) {
                            return Center(
                              child: CircularProgressIndicator.adaptive(),
                            );
                          } else if (state is TopHeadlinesLoaded) {
                            final articles = state.articles;
                            return CustomCarouselSlider(
                              articles: articles ?? [],
                            );
                          } else if (state is TopHeadlinesError) {
                            return Center(
                              child: Text('Error: ${state.errorMessage}'),
                            );
                          }
                          return SizedBox.shrink();
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    TitleHeadlineWidget(title: "Recommendations", onTap: () {}),
                    BlocBuilder<HomeCubit, HomeState>(
                      bloc: homeCubit,
                      buildWhen: (previous, current) =>
                          current is RecommendedArticlesLoading ||
                          current is RecommendedArticlesLoaded ||
                          current is RecommendedArticlesError,
                      builder: (context, state) {
                        if (state is RecommendedArticlesLoading) {
                          return Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        } else if (state is RecommendedArticlesLoaded) {
                          final articles = state.articles;
                          return Recommendationlistwidget(
                            articles: articles ?? [],
                          );
                        } else if (state is RecommendedArticlesError) {
                          return Center(
                            child: Text('Error: ${state.errorMessage}'),
                          );
                        }
                        return SizedBox.shrink();
                      },
                    ),
                    // Add your widgets here
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
