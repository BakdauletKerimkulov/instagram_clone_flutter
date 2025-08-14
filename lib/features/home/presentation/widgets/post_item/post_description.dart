import 'package:flutter/material.dart';

class DescriptionText extends StatefulWidget {
  final String username;
  final String text;
  final int maxLines;

  const DescriptionText({
    required this.username,
    required this.text,
    this.maxLines = 5,
    super.key,
  });

  @override
  State<DescriptionText> createState() => _DescriptionTextState();
}

class _DescriptionTextState extends State<DescriptionText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: RichText(
        maxLines: isExpanded ? null : widget.maxLines,
        overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
        text: TextSpan(
          style: const TextStyle(color: Colors.black, fontSize: 16.0),
          children: [
            TextSpan(
              text: "${widget.username} ",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: '${widget.text} '),
            TextSpan(
              text: isExpanded ? 'less' : 'more...',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
