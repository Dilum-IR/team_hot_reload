import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../utils/helper/device.dart';
import '../../utils/helper/user_handler.dart';

class PostedJobWidget extends StatefulWidget {
  final element;

  const PostedJobWidget({super.key, required this.element});

  @override
  State<PostedJobWidget> createState() => _PostedJobWidgetState();
}

class _PostedJobWidgetState extends State<PostedJobWidget> {
  dynamic _selectedIndex = {};

  @override
  Widget build(BuildContext context) {
    var height = KDeviceUtils.getHeight(context);
    var width = KDeviceUtils.getWidth(context);

    return GestureDetector(
      onTap: () {
        // Get.to(
        //   transition: Transition.cupertino,
        //   duration: Duration(milliseconds: 1200),
        //   () => Joblistning(element: widget.element),
        // );
        setState(() {
          if (_selectedIndex == widget.element) {
            _selectedIndex = {};
          } else {
            _selectedIndex = widget.element;
          }
        });
      },
      child: AnimatedContainer(
        // height: double.maxFinite,
        margin: EdgeInsets.only(bottom: 10),
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
                          Row(
                            children: [
                              CachedNetworkImage(
                                imageUrl: widget.element.image_url,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
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
                              SizedBox(
                                width: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SingleChildScrollView(
                                      child: Container(
                                        width: width - 215,
                                        child: Text(
                                          UserHandler.capitalizeFirstLetter(
                                              widget.element.job_position),
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          maxLines: 2,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    SingleChildScrollView(
                                      child: Container(
                                        width: width - 215,
                                        child: Text(
                                          widget.element.location,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey.shade600,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          maxLines: 2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            child: Row(
                              children: [
                                IconButton(
                                  splashRadius: 20,
                                  splashColor: Colors.orangeAccent,
                                  onPressed: () {},
                                  icon: Icon(
                                    widget.element.is_view
                                        ? Icons.remove_red_eye_outlined
                                        : Icons.visibility_off,
                                    size: 20,
                                  ),
                                ),
                                Text(
                                  widget.element.view.toString(),
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height / 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.ideographic,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 50,
                        ),
                        child: Row(
                          children: [
                            Container(
                              // width: 100,
                              padding: EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 10),
                              height: 30,
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
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              // width: 100,
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 10),
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                widget.element.type_of_workspace,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
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
                                  color: Colors.orangeAccent),
                            ),
                            Text(
                              "/Mo",
                              style:
                                  TextStyle(fontSize: 13, color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
