import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class StoryRow extends StatelessWidget {
  const StoryRow({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => SizedBox(width: 16.0),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 120,
            child: GestureDetector(
              onTap: () {},
              child: Column(
                children: [
                  Expanded(
                    child: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                        'https://i.redd.it/y8xbcb5tiooa1.jpg',
                      ),
                      radius: 56,
                    ),
                  ),
                  Text(
                    'usernameadsfasdfasdfasfdasdf',
                    style: TextStyle(fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
