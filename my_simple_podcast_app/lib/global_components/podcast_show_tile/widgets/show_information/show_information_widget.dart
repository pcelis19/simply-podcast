import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/global_models/podcast.dart';

import 'widgets/host_information.dart';
import 'widgets/other_show_information.dart';
import 'widgets/show_title.dart';

class ShowInformation extends StatelessWidget {
  const ShowInformation({
    Key key,
    @required this.podcastShow,
  }) : super(key: key);
  final Podcast podcastShow;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShowTitle(
          showName: podcastShow.showName,
        ),
        HostInformation(
          artistName: podcastShow.artistName,
        ),
        OtherShowInformation(
          podcastShow: podcastShow,
        )
      ],
    );
  }
}
