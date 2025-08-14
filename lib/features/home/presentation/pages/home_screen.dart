import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone_app/core/entities/post_entity.dart';
import 'package:instagram_clone_app/features/home/presentation/bloc/post_item_cubit/post_item_cubit.dart';
import 'package:instagram_clone_app/features/home/presentation/widgets/post_item/post_item.dart';
import 'package:instagram_clone_app/features/home/presentation/widgets/post_item/story_row.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final PostEntity postEntity = PostEntity(
    uid: 'adsfdasfafsdafasdf',
    userUid: 'asdfasdfasfdfd',
    type: PostType.video,
    contentUrl: 'asdfsdfasfd',
    createdAt: DateTime.now(),
    likeCount: 1000,
    commentCount: 1000,
    isLiked: false,
    isSaved: false,
  );

  final PostEntity imageEntity = PostEntity(
    uid: 'adsfdasfafsdafasdf',
    userUid: 'asdfasdfasfdfd',
    type: PostType.image,
    contentUrl: 'asdfsdfasfd',
    createdAt: DateTime.now(),
    likeCount: 1000,
    commentCount: 1000,
    isLiked: false,
    isSaved: false,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Instagram',
          style: TextStyle(
            fontFamily: 'BillabongTTF',
            fontWeight: FontWeight.w500,
            fontSize: 40.0,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/icons/instagram_heart_icon.svg',
              width: 24,
              height: 24,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/icons/instagram_dm_direct_message_icon.svg',
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 100,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return StoryRow();
          }
          return BlocProvider(
            create: (context) => PostItemCubit(
              isLiked: imageEntity.isLiked,
              isSaved: imageEntity.isSaved,
            ),
            child: PostItem(postEntity: imageEntity, index: index),
          );
        },
      ),
    );
  }
}

class HomeTape extends StatefulWidget {
  const HomeTape({super.key});

  @override
  State<HomeTape> createState() => _HomeTapeState();
}

class _HomeTapeState extends State<HomeTape> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              children: [
                Container(
                  width: 375,
                  height: 54,
                  color: Colors.white,
                  child: Center(
                    child: ListTile(
                      leading: ClipOval(
                        child: SizedBox(
                          width: 35,
                          height: 35,
                          child: Icon(Icons.person),
                        ),
                      ),
                      title: Text('username', style: TextStyle(fontSize: 13)),
                      subtitle: Text(
                        'location',
                        style: TextStyle(fontSize: 11),
                      ),
                      trailing: Icon(Icons.more_vert),
                    ),
                  ),
                ),
                SizedBox(
                  width: 375,
                  height: 375,
                  child: Image.network(
                    //'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGnR1FDGLEFsJpdV20VdeSxSQU61o8alkvNg&s',
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnEXzR3-UegVRLSpfC2Wsz4vjJtrGpKxtmSA&s',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: 375,
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(width: 14),
                      Row(
                        children: [
                          SizedBox(width: 16),
                          Icon(Icons.favorite_outline),
                          SvgPicture.asset(
                            'assets/icons/instagram_heart_icon.svg',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          }, childCount: 1),
        ),
      ],
    );
  }
}
