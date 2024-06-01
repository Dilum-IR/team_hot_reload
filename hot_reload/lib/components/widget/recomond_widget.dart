import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constraints/colors.dart';
import '../../utils/helper/device.dart';
import '../../utils/helper/user_handler.dart';

class RecommondWidget extends StatefulWidget {
  final element;
  final index;

  const RecommondWidget(
      {super.key, required this.element, required this.index});

  @override
  State<RecommondWidget> createState() => _RecommondWidgetState();
}

class _RecommondWidgetState extends State<RecommondWidget> {
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
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              ),
                              const SizedBox(
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
                                        width: width - 185,
                                        child: Text(
                                          UserHandler.capitalizeFirstLetter(
                                              widget.element.job_position),
                                          style: GoogleFonts.lato(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    SingleChildScrollView(
                                      child: Container(
                                        width: width - 185,
                                        child: Text(
                                          widget.element.location,
                                          style: GoogleFonts.lato(
                                            fontSize: 13,
                                            color: Colors.grey.shade600,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.panorama_vertical_sharp,
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
                                style: GoogleFonts.lato(
                                  color: KColors.white,
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
                                style: GoogleFonts.lato(
                                  color: KColors.white,
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
                              style: GoogleFonts.lato(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "/Mo",
                              style: GoogleFonts.lato(color: Colors.grey),
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
