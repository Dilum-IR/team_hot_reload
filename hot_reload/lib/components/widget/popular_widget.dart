import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../utils/helper/device.dart';
import '../../utils/helper/user_handler.dart';

class PopularWidget extends StatefulWidget {
  final element;

  const PopularWidget({
    super.key,
    required this.element,
  });

  @override
  State<PopularWidget> createState() => _PopularWidgetState();
}

class _PopularWidgetState extends State<PopularWidget> {
  dynamic _selectedIndex = {};

  @override
  Widget build(BuildContext context) {
    var height = KDeviceUtils.getHeight(context);
    var width = KDeviceUtils.getWidth(context);

    return GestureDetector(
      onTap: () {
        // print(widget.element.job_position);
        // Get.to(
        //   transition: Transition.cupertino,
        //   duration: Duration(milliseconds: 1200),
        //   () => Joblistning(element: widget.element),
        // );
        setState(() {
          _selectedIndex = -1;
          if (_selectedIndex == widget.element) {
            _selectedIndex = {};
          } else {
            _selectedIndex = widget.element;
          }
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: _selectedIndex == widget.element
                ? Border.all(color: Colors.orangeAccent, width: 1)
                : null,
            boxShadow: _selectedIndex == widget.element
                ? [
                    BoxShadow(
                        color: Colors.orangeAccent.shade100,
                        blurRadius: 5,
                        offset: Offset(0, 0))
                  ]
                : [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 20,
                        offset: Offset(0, 5))
                  ]),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CachedNetworkImage(
                            imageUrl: widget.element.image_url,
                            imageBuilder: (context, imageProvider) => Container(
                              height: 60,
                              width: 55,
                              margin: EdgeInsets.only(top: 15),
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: imageProvider,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => Container(
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.panorama_vertical_sharp,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        UserHandler.capitalizeFirstLetter(
                            widget.element.job_position),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        widget.element.location,
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 13,
                            color: Colors.grey.shade600),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height / 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.ideographic,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 50,
                      ),
                      child: Container(
                        // width: 100,
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        height: 33,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          widget.element.job_type,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          // Text("\$"),
                          Text(
                            widget.element.min_salary !=
                                    widget.element.max_salary
                                ? "\$" +
                                    widget.element.min_salary.toString() +
                                    "K - \$" +
                                    widget.element.max_salary.toString() +
                                    "K"
                                : "\$" +
                                    widget.element.min_salary.toString() +
                                    "K",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              textBaseline: TextBaseline.alphabetic,
                            ),
                          ),
                          Text(
                            "/Mo",
                            style: TextStyle(
                              color: Colors.grey,
                              textBaseline: TextBaseline.alphabetic,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
