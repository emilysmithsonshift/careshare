import 'package:flutter/material.dart';

import '../../../style/style.dart';
import '../../domain/models/story.dart';
import '../../domain/usecases/all_story_usecases.dart';
import '../create_or_edit_story_screen.dart';
import '../view_story_screen.dart';

class StorySummaryWidget extends StatelessWidget {
  final Story story;
  const StorySummaryWidget({Key? key, required this.story}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.all(6),
      decoration: Style.boxDecoration,
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewStoryScreen(
                        story: story,
                      ),
                    ),
                  );
                },
                  child: Text(story.story!)
              ),


              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateOrEditAStoryScreen(
                              story: story,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.grey,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        AllStoryUseCases.removeAStory(story.id!);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.grey,
                      ),
                    ),


                  ],
                ),
              ),

            ],
          ),



        ],
      ),
    );
  }
}
