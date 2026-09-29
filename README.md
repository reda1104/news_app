# Flutter News App

A Flutter news reader with headline browsing, keyword search, article details, and locally saved favorites. The app uses NewsAPI for content, Cubit for state management, and Hive for persistence.

## Features

- Top-headlines carousel and a recommended-articles feed.
- Keyword search through NewsAPI's `/v2/everything` endpoint.
- Article details with source, author, publication date, image, description, and available content.
- Save and remove favorites from article cards, with a dedicated Favorites page.
- Local storage of article and source objects using Hive TypeAdapters.
- Cached network images and loading/error UI.
- Shared article widgets, app theme, and named-route navigation.

The recommended feed is populated from the headlines endpoint; it is not a personalized recommendation engine. Article text is limited to the content supplied by the API.

## Architecture

The code is organized by feature, with shared functionality under `core`.

| Location | Responsibility |
| --- | --- |
| `lib/features/home/` | Headlines, recommendations, article details, request models, service, and Cubit |
| `lib/features/search/` | Search screen, request model, API service, and Cubit |
| `lib/features/favorites/` | Saved-article screen, local-data service, and Cubit |
| `lib/core/cubit/` | Shared favorite add/remove state |
| `lib/core/models/` | Article, source, API response models, and generated Hive adapters |
| `lib/core/services/` | Local storage helpers |
| `lib/core/utils/` | API constants, theme, and routes |
| `lib/core/views/widgets/` | Shared article cards, drawer, and buttons |

Home and Search Cubits call Dio-backed services and emit loading, loaded, or error states. Favorite actions write article lists to Hive; the Favorites feature reads them back for display.

## Tech stack

Flutter · Dart · flutter_bloc · Dio · NewsAPI · Hive · hive_flutter · cached_network_image · carousel_slider

## Run locally

Use a Flutter SDK whose bundled Dart version satisfies `^3.13.1`, the constraint currently declared in `pubspec.yaml`.

```bash
git clone https://github.com/reda1104/news_app.git
cd news_app
flutter pub get
```

1. Obtain your own API key from [NewsAPI](https://newsapi.org/).
2. Set `AppConstants.apiKey` in `lib/core/utils/app_constants.dart` to your key locally. The current code reads this constant directly; it does not read an environment file or `--dart-define`.
3. Keep your personal key out of commits.
4. Launch on a device or emulator with internet access:

```bash
flutter run
```

Generated Hive adapters are included. If you change the annotated models, regenerate them:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Implementation notes

- Favorites store article data locally; they do not sync across devices.
- The detail-page share and favorite buttons are currently UI placeholders. Favorite actions are implemented on article cards.
- The current startup calls Hive initialization without awaiting it. If storage initialization errors occur, initialize Flutter bindings and await `LocalDatabaseHive.initHive()` before `runApp`.
- Live headlines and search require a valid API key and are subject to the provider's account limits.

## Author

[Mohamed Reda](https://github.com/reda1104)
