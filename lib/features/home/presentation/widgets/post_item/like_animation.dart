import 'package:flutter/material.dart';

class LikeAnimationWidget extends StatefulWidget {
  final Widget child;

  const LikeAnimationWidget({super.key, required this.child});

  @override
  State<LikeAnimationWidget> createState() => _LikeAnimationWidgetState();
}

class _LikeAnimationWidgetState extends State<LikeAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  Offset? _tapPosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleDoubleTap(TapDownDetails details) {
    setState(() {
      _tapPosition = details.localPosition;
    });

    _controller.forward(from: 0.0).then((_) {
      setState(() => _tapPosition = null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTapDown: _handleDoubleTap,
      child: Stack(
        children: [
          widget.child,
          if (_tapPosition != null)
            Positioned(
              left: _tapPosition!.dx - 50,
              top: _tapPosition!.dy - 50,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, Widget? child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Opacity(
                      opacity: 1.0 - _scaleAnimation.value / 1.5,
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 100,
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
