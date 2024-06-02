import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hot_reload/app/model/event_model.dart';
import 'package:hot_reload/app/model/user_model.dart';
import 'package:hot_reload/app/screens/organizer/event_placed/create_event_1.dart';
import 'package:hot_reload/components/widget/comman_widget/custom_image.dart';
import 'package:hot_reload/components/widget/comman_widget/space.dart';

import '../../../utils/constraints/colors.dart';
import '../../../utils/constraints/texts.dart';
import '../../../utils/helper/user_handler.dart';
import '../../controllers/user/shared_auth_user.dart';
import '../../controllers/user/user_feature_controller.dart';
import '../../controllers/user/user_signup_controller.dart';
import '../user/profile.dart';
import 'explore.dart';
import 'organizer_profile.dart';

class OrganizerHomeScreen extends StatefulWidget {
  const OrganizerHomeScreen({Key? key}) : super(key: key);

  @override
  State<OrganizerHomeScreen> createState() => _OrganizerHomeScreenState();
}

class _OrganizerHomeScreenState extends State<OrganizerHomeScreen> {
  @override
  void initState() {
    var data = SharedAuthUser.getAuthUser();

    UserHandler.id = data[0];
    UserHandler.userType = data[1];
    UserHandler.email = data[2];
    UserHandler.name = UserHandler.capitalizeFirstLetter(data[3]);

    // getAllEvent();
    super.initState();
  }

  // void getUserData() async {
  //   List<UserModel> eventData = await userFeatureController.getAllUsersData();
  //   print(eventData);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(Icons.menu));
          },
          // child: IconButton(
          //   onPressed: () {
          //     Get.to(
          //       // () => UserProfile(),
          //     );
          //   },
          //   icon: Icon(Icons.add),
          // ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                suffixIcon: Icon(Icons.filter_list),
                hintText: 'Search Events',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 16.0,
              children: [
                _buildStatusCard('Projects Completed', '1.3 K'),
                _buildStatusCard('Active Volunteers', '754'),
                _buildStatusCard('Donations Received', '\$6M+'),
              ],
            ),
            SizedBox(height: 6.0),
            Text('Next Event',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            _buildEventCard('Wildlife Habitat Enhancement',
                'Everglades National Park, Florida', '1 day'),
            SizedBox(height: 16.0),
            Text('Organizations',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                spacing: 12.0,
                runSpacing: 16.0,
                children: [
                  _buildOrganizationCircle('Planet Protectors'),
                  _buildOrganizationCircle('Clean Air Initiative'),
                  _buildOrganizationCircle('Unity in Action'),
                  _buildOrganizationCircle('Active Lives'),
                  _buildOrganizationCircle('Hope Crew'),
                  _buildOrganizationCircle('View All'),
                ],
              ),
            ),
            SizedBox(height: 26.0),
            Text('Current Programs',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            _buildEventCard('Current Program Example', '', '12 days'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 5,
        onPressed: () {
          Get.to(() => CreateEvent1(),
              duration: Duration(milliseconds: 1000),
              transition: Transition.rightToLeft);
        },
        child: Icon(
          Icons.add,
          color: KColors.white,
        ),
      ),
      drawer: MyDrawer(),
    );
  }

  Widget MyDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => OrganizerProfile(),
                        transition: Transition.cupertino,
                        duration: Duration(seconds: 1));
                  },
                  child: Container(
                    child: CustomImage(
                      image: SharedAuthUser.getimageUrl() ?? KTexts.profileImg,
                      size: 110,
                    ),
                  ),
                ),
                KW12Space(),
                SizedBox(
                  width: 100,
                  child: Text(
                    '${UserHandler.name}',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: KColors.primary,
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Get.to(() => OrganizerHomeScreen(),
                  transition: Transition.cupertino,
                  duration: Duration(seconds: 1));
              // getAllEvent();
            },
          ),
          ListTile(
            leading: Icon(Icons.ac_unit),
            title: Text('Explore'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Get.to(() => Explore(),
                  transition: Transition.cupertino,
                  duration: Duration(seconds: 1));
            },
          ),
          ListTile(
            leading: Icon(Icons.contact_page),
            title: Text('Event'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              // Get.to(() => Events(),
              //     transition: Transition.cupertino,
              //     duration: Duration(seconds: 1));
              //
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard(String title, String count) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            count,
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(String title, String location, String daysLeft) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 120.0,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(8.0)),
                ),
                child: Center(
                  child: Icon(Icons.image, size: 50.0, color: Colors.grey[600]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      location,
                      style: TextStyle(fontSize: 14.0, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: -5.0,
            right: 18.0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 60,
                  height: 95,
                  child: Image.asset(
                    'assets/images/ribbon.png',
                    width: 60,
                    height: 80,
                    fit: BoxFit.fill,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment
                      .start, // Change to MainAxisAlignment.start
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      daysLeft.split(' ')[0], // Get the number part
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      daysLeft.split(' ')[1], // Get the 'day' part
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrganizationCircle(String name) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30.0,
          backgroundColor: Colors.grey[200],
          child: Icon(Icons.group, size: 30.0),
        ),
        SizedBox(height: 8.0),
        Container(
          width: 60.0, // Adjust the width to control wrapping
          child: Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.0),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
