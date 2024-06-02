import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hot_reload/app/screens/user/profile.dart';
import 'package:hot_reload/components/style/text_styles.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../../components/loading_screen.dart';
import '../../../components/style/app_input_style.dart';
import '../../../components/widget/comman_widget/custom_image.dart';
import '../../../components/widget/comman_widget/space.dart';
import '../../../components/widget/popular_widget.dart';
import '../../../components/widget/recomond_widget.dart';
import '../../../utils/constraints/colors.dart';
import '../../../utils/constraints/texts.dart';
import '../../../utils/helper/device.dart';
import '../../../utils/helper/user_handler.dart';
import '../../../components/widget/comman_widget/show_confirm.dart';
import '../../controllers/employee/employee_feature_contoller.dart';
import '../../controllers/payment/payment_controller.dart';
import '../../controllers/send_mail/send_mail.dart';
import '../../controllers/user/shared_auth_user.dart';
import '../../controllers/user/user_feature_controller.dart';
import '../../controllers/user/user_signup_controller.dart';
import '../../model/employee_job_post.dart';
import '../../model/event_model.dart';
import '../welcome_screen.dart';
import 'manage_application1.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => UserHomeScreenState();
}

class UserHomeScreenState extends State<UserHomeScreen> {
  bool _isloading = false;

  final userController = Get.put(UserSignUpController());
  final userFeatureController = Get.put(UserFeatureController());
  List<EventModel> eventData = [];

  void getAllEvent() async {
    List<EventModel> eventData = await userFeatureController.getAllEvents();
    print(eventData);
  }

  @override
  void initState() {
    var data = SharedAuthUser.getAuthUser();

    UserHandler.id = data[0];
    UserHandler.userType = data[1];
    UserHandler.email = data[2];
    UserHandler.name = UserHandler.capitalizeFirstLetter(data[3]);

    print(data);
    // get posted jobs

    setState(() {
      _isloading = true;
    });

    allEvents();
    super.initState();
  }

  void allEvents() async {
    setState(() {
      _isloading = false;
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    // TODO: implement dispose
    _isloading = false;

    super.dispose();
  }

  final controller = Get.put(EmployeeFeatureController());
  // final userController = Get.put(UserFeatureController());

  List<EmployeeJobPost> postedJob = [];
  List<EmployeeJobPost> recomenrJob = [];

  var type = [];

  int _current = 0;

  final CarouselController _carouselController = CarouselController();
  TextEditingController searchController = TextEditingController();

  final emailController = Get.put(SendEmail());
  final paymentController = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    var height = KDeviceUtils.getHeight(context);
    var width = KDeviceUtils.getWidth(context);

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: _isloading
            ? Text(
                "Loading ...",
                style: GoogleFonts.lato(
                  color: Colors.black45,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              )
            : Container(),
        leading: Builder(
          builder: (context) {
            return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(Icons.menu));
          },
        ),
        actions: [
          IconButton(
            splashRadius: 20,
            onPressed: () {
              if (kDebugMode) {
                print("send email");
              }
              // emailController.sendEmail(
              //   name: "Dilum Induwara",
              //   message: "this is a hot reload email content",
              //   email: "dirathnayake1911441@gmail.com",
              //   subject: "hot reload send the email",
              // );
            },
            icon: const Icon(
              Icons.share,
              color: Colors.black,
              size: 30,
            ),
          ),
          IconButton(
            splashRadius: 20,
            onPressed: () {
              ShowConfirm.dialog(context, "Do you want to logout ?", () {
                SharedAuthUser.removeUser();
                SharedAuthUser.removeInfoUser();
                SharedAuthUser.removeimageUrl();

                Get.offAll(
                  transition: Transition.cupertino,
                  duration: const Duration(milliseconds: 1200),
                  () => const WelcomeScreen(),
                );
                setState(() {});
              });
            },
            icon: const Icon(
              Icons.logout_rounded,
              color: Colors.black,
              size: 30,
            ),
          ),
        ],
      ),
      body: _isloading == true
          ? const LoadingScreen()
          : SingleChildScrollView(
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
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8.0),
                  Container(
                    height: 180.0,
                    width: double.infinity,
                    child: _buildEventCard('Wildlife Habitat Enhancement',
                        'Everglades National Park, Florida', '1 day'),
                  ),
                  SizedBox(height: 16.0),
                  Text('Organizations',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold)),
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
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8.0),
                  _buildEventCard('Current Program Example', '', '12 days'),
                ],
              ),
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
                    Get.to(() => UserProfile(),
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
              Get.to(() => UserHomeScreen(),
                  transition: Transition.cupertino,
                  duration: Duration(seconds: 1));
              getAllEvent();
            },
          ),
          ListTile(
            leading: Icon(Icons.ac_unit),
            title: Text('Applications'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Get.to(() => manageapplication1(),
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
}

// StreamBuilder<int>(
// stream: appointmentController
//     .getQueueNumberForVet("jWzaSWbkHzXNKHzydlAz"),
// builder: (context, snapshot) {
// if (snapshot.hasData) {
// // print(snapshot.data);
// return KTextTitle(
// text: snapshot.data.toString(),
// );
// } else if (snapshot.hasError) {
// return Text('Error: ${snapshot.error}');
// } else {
// return const CircularProgressIndicator();
// }
// },
// ),

// [Controller method]

// get the vet queue number
// Stream<int> getQueueNumberForVet(String vetId) {
//   StreamController<int> queueNumberController = StreamController<int>();
//
//   FirebaseFirestore.instance
//       .collection('vet')
//       .doc(vetId)
//       .snapshots()
//       .listen((DocumentSnapshot snapshot) {
//     if (snapshot.exists) {
//       final int queueNumber =
//       (snapshot.data() as Map<String, dynamic>)['queue'];
//       queueNumberController.add(queueNumber);
//     } else {
//       queueNumberController.add(-1);
//     }
//   });
//
//   return queueNumberController.stream;
// }
