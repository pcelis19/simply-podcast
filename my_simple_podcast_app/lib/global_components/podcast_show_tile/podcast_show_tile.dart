import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/global_utils/size_config.dart';
import 'package:my_simple_podcast_app/global_models/podcast.dart';

import 'widgets/cover_art_widget/cover_art_widget.dart';
import 'widgets/show_information/show_information_widget.dart';

class PodcastShowTile extends StatelessWidget {
  const PodcastShowTile(
      {@required this.podcastShow, @required this.maxTileSize});
  final Podcast podcastShow;
  final double maxTileSize;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return decoration(
      CoverArt(imageUrl: podcastShow.imageUrl),
      ShowInformation(podcastShow: podcastShow),
    );
  }

  /// This is the decoration applied to both widgets.
  Widget decoration(CoverArt coverArt, ShowInformation showInformation) {
    return Container(
      height: SizeConfig.screenHeight * maxTileSize,
      child: Card(
        elevation: 5.0,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: coverArt,
              ),
              Expanded(
                flex: 4,
                child: showInformation,
              )
            ],
          ),
        ),
      ),
    );
  }
}
