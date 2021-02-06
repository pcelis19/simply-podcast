import 'package:flutter/material.dart';
import 'package:my_simple_podcast_app/models/partial_podcast_information.dart';
import 'package:my_simple_podcast_app/widgets/host_information.dart';
import 'package:my_simple_podcast_app/widgets/other_show_information.dart';
import 'package:my_simple_podcast_app/widgets/show_title.dart';

class ShowInformation extends StatelessWidget {
  const ShowInformation({
    Key key,
    @required this.podcastShow,
  }) : super(key: key);
  final PartialPodcastInformation podcastShow;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShowTitle(
          showName: podcastShow.podcastName,
        ),
        HostInformation(
          artistName: podcastShow.artistName,
        ),
        OtherShowInformation(
          partialPodcastInformation: podcastShow,
        )
      ],
    );
  }
}
