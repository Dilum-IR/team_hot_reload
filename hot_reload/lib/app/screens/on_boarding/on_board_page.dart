import 'package:flutter/material.dart';

class OnBoardPage extends StatefulWidget {
  const OnBoardPage({
    Key? key,
    required this.color,
    required this.image,
    required this.title,
    required this.sub_title,
  }) : super(key: key);

  final String image;
  final String title;
  final String sub_title;
  final Color color;

  @override
  State<OnBoardPage> createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    animation();
    super.initState();
  }

  void animation() {
    animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    fadeAnimation = CurvedAnimation(
        parent: animationController, curve: Curves.easeInOutCubic);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: widget.color,
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height / 7,
          ),
          FadeTransition(
            opacity: fadeAnimation,
            child: Image(
              image: AssetImage(
                widget.image,
              ),
              width: size.width / 1.1,
              height: size.height / 2.5,
            ),
          ),
          SizedBox(
            height: size.height / 20,
          ),
          Container(
            child: Column(
              children: [
                Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    fontFamily: "",
                  ),
                ),
                Text(
                  "${widget.sub_title}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    // decoration: TextDecoration.overline,
                    color: Colors.black45,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const Expanded(flex: 1, child: SizedBox()),
          // CircleAvatar(
          //   radius: 53,
          //   backgroundColor: Colors.white,
          //   child: CircleAvatar(
          //     radius: 50,
          //     backgroundColor: widget.color,
          //     child: GestureDetector(
          //       onTap: () {
          //         print("object");
          //       },
          //       child: CircleAvatar(
          //         backgroundColor: Colors.black87,
          //         radius: 40,
          //         // width: 200,
          //         // height: 200,
          //         // decoration: BoxDecoration(
          //         // color: Colors.deepPurple,
          //         //   // shape: BoxShape.circle,
          //         // ),
          //         child: Icon(
          //           Icons.arrow_forward_ios_rounded,
          //           size: 35,
          //           color: Colors.white,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
