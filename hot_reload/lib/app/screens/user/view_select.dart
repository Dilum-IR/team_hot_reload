import 'package:flutter/material.dart';

class ViewSelect extends StatefulWidget {
  const ViewSelect({
    Key? key,
    required this.img,
  }) : super(key: key);

  final String img;
  @override
  State<ViewSelect> createState() => _ViewSelectState();
}

class _ViewSelectState extends State<ViewSelect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRect(
              child: Hero(
                tag: "image-${widget.img}",
                child: Image.asset(widget.img),
              ),
            )
          ],
        ),
      ),
    );
  }
}
