import 'package:cached_network_image/cached_network_image.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone_app/core/entities/post_entity.dart';
import 'package:instagram_clone_app/features/home/presentation/util/video_item.dart';
import 'package:instagram_clone_app/features/home/presentation/widgets/post_item/like_animation.dart';
import 'package:instagram_clone_app/features/home/presentation/widgets/post_item/post_description.dart';
import 'package:instagram_clone_app/features/home/presentation/widgets/post_item/post_header.dart';

class PostItem extends StatefulWidget {
  final PostEntity postEntity;
  final int index;

  const PostItem({super.key, required this.postEntity, required this.index});

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  bool isLiked = false;
  bool isSaved = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PostHeader(index: widget.index),
        _buildContent(widget.postEntity.type),
        Row(
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  isLiked = !isLiked;
                });
              },
              icon: SvgPicture.asset(
                isLiked
                    ? 'assets/icons/instagram_heart_icon_filled.svg'
                    : 'assets/icons/instagram_heart_icon.svg',
                height: 24,
                width: 24,
                colorFilter: isLiked
                    ? const ColorFilter.mode(Colors.red, BlendMode.srcIn)
                    : null,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/icons/instagram_comment_icon.svg',
                height: 24,
                width: 24,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/icons/instagram_share_icon.svg',
                height: 24,
                width: 24,
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                setState(() {
                  isSaved = !isSaved;
                });
              },
              icon: SvgPicture.asset(
                isSaved
                    ? 'assets/icons/instagram_save_icon_filled.svg'
                    : 'assets/icons/instagram-save-icon.svg',
                height: 24,
                width: 24,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 4.0,
            bottom: 8.0,
          ),
          child: DescriptionText(
            username: widget.postEntity.userUid,
            text: generateLoremIpsum(),
          ),
        ),
      ],
    );
  }

  String generateLoremIpsum() {
    return Faker().lorem.words(100).join(' ');
  }

  Widget _buildContent(PostType type) {
    return LikeAnimationWidget(
      child: switch (type) {
        PostType.image => AspectRatio(
          aspectRatio: 9 / 12,
          child: Container(
            color: Colors.black87,
            child: FittedBox(
              fit: BoxFit.cover,
              child: CachedNetworkImage(
                imageUrl:
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnEXzR3-UegVRLSpfC2Wsz4vjJtrGpKxtmSA&s',
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, object) =>
                    Center(child: Text('Could not download image')),
              ),
            ),
          ),
        ),
        PostType.video => VideoItem(
          videoUrl:
              'https://cdn.pixabay.com/video/2015/08/07/5-135665794_large.mp4',
        ),
        PostType.carousel => AspectRatio(
          aspectRatio: 9 / 16,
          child: Text('CarouselContent'),
        ),
      },
    );
  }
}
