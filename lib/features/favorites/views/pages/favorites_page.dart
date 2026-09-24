import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.back_hand),
        ),
      ),
      body: Center(child: Text("Favourites")),
    );
  }
}
