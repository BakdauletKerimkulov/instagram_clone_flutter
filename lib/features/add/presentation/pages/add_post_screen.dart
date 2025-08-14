import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram_clone_app/common/app_colors.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final List<Widget> _mediaList = [];
  final List<File> path = [];
  int currentPage = 0;
  int? lastPage;

  File? currentImage;

  Future<void> _turnOnCamera(BuildContext context) async {
    final Permission cameraPs = Permission.camera;
    await cameraPs
        .onDeniedCallback(() {
          return;
        })
        .onGrantedCallback(() {
          context.go('/add/add_post/camera');
        })
        .onPermanentlyDeniedCallback(() async {
          await openAppSettings();
        })
        .request();
  }

  Future<void> _fetchNewMedia() async {
    lastPage = currentPage;
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth || ps.hasAccess) {
      List<AssetPathEntity> album = await PhotoManager.getAssetPathList(
        onlyAll: true,
      );

      if (album.isEmpty) return;

      List<AssetEntity> media = await album[0].getAssetListPaged(
        page: currentPage,
        size: 60,
      );

      List<Widget> temp = [];

      for (var asset in media) {
        if (asset.type == AssetType.image) {
          final file = await asset.file;
          if (file != null) {
            path.add(file);
            if (path.isNotEmpty) {
              temp.add(
                FutureBuilder(
                  future: asset.thumbnailDataWithSize(
                    const ThumbnailSize(200, 200),
                  ),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Positioned.fill(
                        child: Image.memory(snapshot.data!, fit: BoxFit.cover),
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              );
            }
          }
        }
      }
      setState(() {
        _mediaList.addAll(temp);
      });
    } else {
      await PhotoManager.openSetting();
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchNewMedia();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final currImageHeight = screenHeight * 0.4;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('New Post', style: TextStyle(color: Colors.black)),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              'Next',
              style: TextStyle(fontSize: 15.0, color: Colors.blue),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: currImageHeight,
                child: currentImage != null
                    ? Image.file(currentImage!)
                    : Container(),
              ),
              Container(
                width: double.infinity,
                height: 40,
                color: Colors.white,
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    Text(
                      'Recent',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: Text(
                      "You've given Instagram access to a select number of photos and videos",
                      maxLines: 2,
                      style: TextStyle(fontSize: 14.0, color: Colors.grey),
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Manage',
                      style: TextStyle(color: AppColors.primaryColor),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 1.0,
                  crossAxisSpacing: 1.0,
                ),
                itemCount: 1 + _mediaList.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return GestureDetector(
                      onTap: () => _turnOnCamera(context),
                      child: Container(
                        height: 200,
                        width: 200,
                        color: Colors.grey,
                        child: Center(child: Icon(Icons.camera_alt, size: 36)),
                      ),
                    );
                  }
                  return _mediaList[index - 1];
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
