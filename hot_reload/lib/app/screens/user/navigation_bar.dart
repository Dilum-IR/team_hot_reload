import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hot_reload/app/screens/user/profile.dart';
import 'package:hot_reload/app/screens/user/search_list.dart';
import 'package:hot_reload/app/screens/user/user_home_screen.dart';

import '../../../utils/constraints/colors.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => Custom_NavigationBarState();
}

class Custom_NavigationBarState extends State<CustomNavigationBar> {
  List<IconData> navIcons = [
    Icons.home,
    Icons.favorite,
    Icons.person,
  ];
  List<String> navTitle = [
    "Home",
    "Favorite",
    "Profile",
  ];
  List<Widget> navScreen = [
    const UserHomeScreen(),
    // SavedJobs(),
    const SearchList(),
    const UserProfile(),
  ];

  int selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // todo: select pages
          navScreen[selectIndex],
          // todo: navigation bar
          _navBar()
        ],
      ),
    );
  }

  Widget _navBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 65,
        margin: const EdgeInsets.only(
          left: 17,
          right: 17,
          bottom: 10,
        ),
        decoration: BoxDecoration(
          color: KColors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: KColors.black.withAlpha(30),
              blurRadius: 20,
              spreadRadius: 10,
            )
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: navIcons.map((icon) {
            int index = navIcons.indexOf(icon);
            bool isSelected = selectIndex == index;
            return GestureDetector(
              onTap: () {
                selectIndex = index;
                setState(() {});
              },
              child: Material(
                color: Colors.transparent,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(
                        left: 35,
                        right: 35,
                        bottom: 0,
                        top: 15,
                      ),
                      child: Icon(
                        icon,
                        color: isSelected ? Colors.orangeAccent : KColors.black,
                      ),
                    ),
                    Text(
                      navTitle[index],
                      style: GoogleFonts.lato(
                        color: isSelected ? Colors.orangeAccent : KColors.black,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
