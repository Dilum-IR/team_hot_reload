import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hot_reload/app/screens/user/view_select.dart';
import 'package:hot_reload/utils/constraints/colors.dart';
import 'package:hot_reload/utils/constraints/texts.dart';
import 'package:hot_reload/utils/helper/device.dart';

import '../../../components/style/app_input_style.dart';
import '../../../components/style/text_styles.dart';

class SearchList extends StatefulWidget {
  const SearchList({Key? key}) : super(key: key);

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
  }

  bool startAnimation = false;

  final TextEditingController searchController = TextEditingController();
  List allResults = [
    {
      "name": "Dilum INduwara",
    },
    {
      "name": "Ruchira lakmal",
    },
    {
      "name": "chamod henda",
    },
    {
      "name": "wikum preethika",
    },
    {
      "name": "do do do",
    },
  ];

  List resultList = [];

  getClientStream() async {
    // var data = await FirebaseFirestore.instance
    //     .collection("search")
    //     .orderBy("name")
    //     .get();
    //
    // setState(() {
    //   allResults = data.docs;
    // });
    _onSearchResultList("");
  }

  void _onSearchChanged(String searchText) {
    print(searchController.text);
    _onSearchResultList(searchText);
  }

  void _onSearchResultList(String searchText) {
    var showResult = [];
    if (searchText != "") {
      for (var item in allResults) {
        var name = item['name'].toString().toLowerCase();

        if (name.contains(searchText.toLowerCase())) {
          showResult.add(item);
        }
      }
    } else {
      showResult = List.from(allResults);
    }
    setState(() {
      resultList = showResult;
    });
  }

  @override
  void didChangeDependencies() {
    getClientStream();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = KDeviceUtils.getWidth(context);
    var height = KDeviceUtils.getHeight(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KColors.white,
        title: TextField(
          controller: searchController,
          onChanged: (searchText) => _onSearchChanged(searchText),
          // obscuringCharacter: AppInputStyle.obscuringCharacter,
          decoration: InputDecoration(
            // suffixIcon: IconButton(
            //   splashRadius: 5,
            //   onPressed: () {},
            //   icon: AppInputStyle.searchIcon,
            // ),
            border: AppInputStyle.outlineInputBorder,
            focusedBorder: AppInputStyle.outlineInputBorder,
            contentPadding: AppInputStyle.contentPadding,
            // filled: validpassword ? true : false,

            fillColor: AppInputStyle.validFillColor,
            hintText: "Search",
            labelText: "Search",
            hintStyle: KTextStyles.smallerGText,
            labelStyle: KTextStyles.smallerBText,
            floatingLabelStyle: KTextStyles.blackXlText,
            prefixIcon: AppInputStyle.searchIcon,
          ),
        ),
      ),
      body: resultList.length != 0
          ? ListView.builder(
              padding: EdgeInsets.only(top: 10),
              itemCount: resultList.length,
              itemBuilder: (context, index) {
                return AnimatedContainer(
                  curve: Curves.easeInOut,
                  duration: Duration(milliseconds: 300 + (index * 100)),
                  transform: Matrix4.translationValues(
                      startAnimation ? 0 : width, 0, 0),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(
                            () => ViewSelect(img: KTexts.sliderImages[index]));
                      },
                      child: Row(
                        children: [
                          Container(
                            width: width / 2.2,
                            height: 50,
                            child: Hero(
                              tag: "image-${KTexts.sliderImages[index]}",
                              child: Image.asset(KTexts.sliderImages[index]),
                            ),
                          ),
                          Container(
                            width: width / 2,
                            height: 50,
                            child: ListTile(
                              title: Text("${resultList[index]['name']}"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              })
          : const Center(child: Text("result not available")),
    );
  }
}
