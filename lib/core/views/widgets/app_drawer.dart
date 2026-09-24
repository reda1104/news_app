import 'package:flutter/material.dart';
import 'package:news_app/core/utils/route/app_routes.dart';
import 'package:news_app/core/utils/theme/app_colors.dart';
import 'package:news_app/features/favorites/views/pages/favorites_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: DrawerHeader(
              decoration: const BoxDecoration(color: AppColors.primaryColor),
              child: Text(
                "News App",
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: Text("Home"),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.favorite_rounded),
            title: Text(
              "Favorite",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.favorites);
            },
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(
              "Profile",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
