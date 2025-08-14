import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PostHeader extends StatelessWidget {
  final int index;
  const PostHeader({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: CachedNetworkImageProvider(
              'https://i.redd.it/krp6tpdwcmgc1.jpeg',
            ),
            backgroundColor: Colors.grey[200],
          ),
          SizedBox(width: 16.0),
          Text('user_name $index', style: TextStyle(fontSize: 20.0)),
          Spacer(),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/icons/ellipsis-v-icon.svg',
              height: 20,
              width: 20,
            ),
          ),
        ],
      ),
    );
  }
}
