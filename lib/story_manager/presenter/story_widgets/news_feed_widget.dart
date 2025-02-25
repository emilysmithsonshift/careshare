import 'package:flutter/material.dart';
import 'story_summary_widget.dart';
import '../../domain/models/story.dart';
import 'news_feed_controller.dart';

class NewsFeed extends StatefulWidget {
  const NewsFeed({Key? key}) : super(key: key);

  @override
  State<NewsFeed> createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  final controller = NewsFeedController();

  @override
  void initState() {
    controller.fetchStorys();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: ValueListenableBuilder(
        valueListenable: controller.status,
        builder: (context, status, _) {
          if (status == PageStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (status == PageStatus.error) {
            return const Center(child: Text('Couldn''t find any stories'));
          }
          return SingleChildScrollView(
            reverse: true,
            child: Column(
                children: controller.storyList.map((Story story) {
                  return StorySummaryWidget(story: story);
                }).toList()),
          );
        },
      ),
    );
  }
}
