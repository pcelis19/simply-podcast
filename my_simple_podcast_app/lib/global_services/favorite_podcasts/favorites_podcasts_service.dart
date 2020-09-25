import 'dart:async';

import 'package:my_simple_podcast_app/global_models/podcast.dart';

import 'shared_preferences_favorites_podcasts.dart';

/// This handles the services that the UI will see, but hides
/// any interactions with the cache. Saving to cache takes longer
/// than saving to ram. So we will update the ram portion first, and
/// take care of the saving to cache in the background
class FavoritePodcastsService {
  static final FavoritePodcastsService _favoritesPodcastsService =
      FavoritePodcastsService.internal();
  factory FavoritePodcastsService() {
    return _favoritesPodcastsService;
  }
  FavoritePodcastsService.internal();

  /// this is the stream controller that other UIs will contect to
  StreamController<List<Podcast>> _streamController =
      StreamController<List<Podcast>>.broadcast();

  /// this is the list of podcasts saved to RAM
  List<Podcast> _favoritePodcasts = [];

  /// internal boolean, so that when initializing  the class we
  /// do not do redudant work
  bool _loadedFavorites = false;

  //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
  //$$$$$$$$$$ Public Functions $$$$$$$$$$$$$$$$$$$$$$$
  //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

  /// this returns a stream of podcast shows because podcast shows may be added and deleted, therefore
  /// we have to continue to listen to this stream
  Stream<List<Podcast>> get favoritePodcasts {
    return _streamController.stream;
  }

  /// checks if a podcast is a favorited podcast
  Future<bool> isPodcastFavorite(Podcast podcast) async {
    await intializeFavorites();
    return _favoritePodcasts.contains(podcast);
  }

  /// removes podcast from favorites
  Future<void> removePodcastFromFavorites(Podcast podcast) async {
    await intializeFavorites();
    if (_favoritePodcasts.contains(podcast)) {
      _favoritePodcasts.remove(podcast);
      _streamController.add(_favoritePodcasts);
      // remove from cache
      FavoritePodcastsSharedPreferencesService()
          .updateListOfFavoritePodcastsToCache(_favoritePodcasts);
    }
  }

  /// adds podcast to favorites
  Future<void> addPodcastToFavorites(Podcast podcast) async {
    await intializeFavorites();
    if (!_favoritePodcasts.contains(podcast)) {
      _favoritePodcasts.add(podcast);
      _streamController.add(_favoritePodcasts);
      FavoritePodcastsSharedPreferencesService()
          .updateListOfFavoritePodcastsToCache(_favoritePodcasts);
    }
  }

  //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
  //$$$$$$$$$$ Private Functions $$$$$$$$$$$$$$$$$$$$$$
  //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

  /// make sure that things
  /// are intialized
  Future<void> intializeFavorites() async {
    // no need to redo this intensive work over and over
    if (!_loadedFavorites) {
      // try {
      List<Podcast> unpackedPodcasts =
          await FavoritePodcastsSharedPreferencesService()
              .unpackedFavoritePodcasts;

      _favoritePodcasts = unpackedPodcasts == null ? [] : unpackedPodcasts;
      _loadedFavorites = true;
      _streamController.add(_favoritePodcasts);
      // } catch (e) {
      //   log("[ERROR: FavoritePodcastsSharedPreferencesService().favoritePodcasts]: ${e.toString()}");
      //   _loadedFavorites = false;
      // }
    }
  }
}
