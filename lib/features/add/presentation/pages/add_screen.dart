import 'package:flutter/material.dart';
import 'package:instagram_clone_app/features/add/presentation/pages/add_post_screen.dart';
import 'package:instagram_clone_app/features/add/presentation/pages/add_reels_screen.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

int _currentIndex = 0;

class _AddScreenState extends State<AddScreen> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  onPageChanged(int page) {
    setState(() {
      _currentIndex = page;
    });
  }

  navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const containerWidth = 120.0;
    final rightPadding = (screenWidth - containerWidth) / 2;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView(
              controller: pageController,
              onPageChanged: onPageChanged,
              children: const [AddPostScreen(), AddReelsScreen()],
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              bottom: 10.0,
              right: _currentIndex == 0 ? rightPadding + 30 : rightPadding - 30,
              child: Container(
                width: 120,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => navigationTapped(0),
                      child: Text(
                        'Post',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          color: _currentIndex == 0
                              ? Colors.white
                              : Colors.grey,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => navigationTapped(1),
                      child: Text(
                        'Reels',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          color: _currentIndex == 1
                              ? Colors.white
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
