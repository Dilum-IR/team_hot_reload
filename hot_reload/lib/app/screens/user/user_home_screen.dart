import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hot_reload/components/style/text_styles.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../../components/loading_screen.dart';
import '../../../components/style/app_input_style.dart';
import '../../../components/widget/popular_widget.dart';
import '../../../components/widget/recomond_widget.dart';
import '../../../utils/constraints/colors.dart';
import '../../../utils/helper/device.dart';
import '../../../utils/helper/user_handler.dart';
import '../../../components/widget/comman_widget/show_confirm.dart';
import '../../controllers/employee/employee_feature_contoller.dart';
import '../../controllers/payment/payment_controller.dart';
import '../../controllers/send_mail/send_mail.dart';
import '../../controllers/user/shared_auth_user.dart';
import '../../controllers/user/user_feature_controller.dart';
import '../../model/employee_job_post.dart';
import '../welcome_screen.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => UserHomeScreenState();
}

class UserHomeScreenState extends State<UserHomeScreen> {
  bool _isloading = false;

  @override
  void initState() {
    var data = SharedAuthUser.getAuthUser();

    UserHandler.id = data[0];
    UserHandler.userType = data[1];
    UserHandler.email = data[2];
    UserHandler.name = UserHandler.capitalizeFirstLetter(data[3]);

    print(data);
    // get posted jobs
    getAllJobs();

    setState(() {
      _isloading = true;
    });
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    // TODO: implement dispose
    _isloading = false;

    super.dispose();
  }

  final controller = Get.put(EmployeeFeatureController());
  final userController = Get.put(UserFeatureController());

  List<EmployeeJobPost> postedJob = [];
  List<EmployeeJobPost> recomenrJob = [];

  var type = [];

  Future<void> getAllJobs() async {
    postedJob = await controller.getAllJob();

    // list sort for date
    postedJob
        .sort((ele_1, ele_2) => ele_2.post_time.compareTo(ele_1.post_time));

    // get types
    for (var x in postedJob) {
      if (!type.contains(x.job_type)) {
        type.add(x.job_type);
      }
      if (!type.contains(x.type_of_workspace)) {
        type.add(x.type_of_workspace);
      }
      if (!type.contains(x.category)) {
        type.add(x.category);
      }
    }
    setState(() {
      _isloading = false;
    });
  }

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
        leading: IconButton(
          splashRadius: 20,
          onPressed: () {
            print("payment taped");
            paymentController.startOneTimePayment(context);
          },
          icon: const Icon(
            Icons.menu_rounded,
            color: Colors.black,
            size: 30,
          ),
        ),
        actions: [
          IconButton(
            splashRadius: 20,
            onPressed: () {
              if (kDebugMode) {
                print("send email");
              }
              emailController.sendEmail(
                name: "Dilum Induwara",
                message: "this is a hot reload email content",
                email: "dirathnayake1911441@gmail.com",
                subject: "hot reload send the email",
              );
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
          : Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 17,
                    right: 17,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: width - 90,
                        child: TextField(
                          cursorColor: Colors.black,
                          cursorHeight: 20,
                          controller: searchController,
                          // onChanged: (search) => onSearchChanged(search),
                          decoration: InputDecoration(
                            border: AppInputStyle.outlineInputBorder,
                            focusedBorder: AppInputStyle.outlineInputBorder,
                            contentPadding: AppInputStyle.contentPadding,
                            fillColor: AppInputStyle.validFillColor,
                            hintText: "Search Jobs",
                            labelText: "Search Jobs",
                            hintStyle: KTextStyles.smallerGText,
                            labelStyle: KTextStyles.smallerBText,
                            floatingLabelStyle: KTextStyles.blackXlText,
                            prefixIcon: const Icon(
                              Icons.search,
                              size: 30,
                              color: Colors.orangeAccent,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10)),
                        child: IconButton(
                          onPressed: () {
                            print("object");
                          },
                          icon: const Icon(
                            Icons.filter_list_sharp,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 17.0),
                  child: Text(
                    "Most Popular",
                    style: GoogleFonts.lato(
                      color: KColors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                postedJob.isEmpty
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 12),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 17,
                        ),
                        width: width,
                        height: height / 3.6,
                        decoration: BoxDecoration(
                            color: Colors.orangeAccent.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: Text(
                            textAlign: TextAlign.center,
                            "No jobs posted. Please check back later.",
                            style: GoogleFonts.lato(
                              color: Colors.orangeAccent,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                    : SizedBox(
                        width: width,
                        height: height / 3.6,
                        child: Container(
                          // width: double.infinity,
                          // height: double.infinity,
                          child: CarouselSlider(
                              carouselController: _carouselController,
                              options: CarouselOptions(
                                  initialPage: 0,
                                  autoPlay: true,
                                  padEnds: true,
                                  animateToClosest: true,
                                  enlargeCenterPage: true,
                                  autoPlayInterval: const Duration(seconds: 4),
                                  autoPlayAnimationDuration:
                                      const Duration(milliseconds: 800),
                                  height: height / 3.9,
                                  // aspectRatio: 9 / 16,
                                  viewportFraction: 0.67,
                                  enlargeFactor: 0.427,
                                  pageSnapping: true,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _current = index;
                                    });
                                  }),
                              items: postedJob.map((element) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return PopularWidget(
                                      element: element,
                                    );
                                  },
                                );
                              }).toList()),
                        ),
                      ),
                const SizedBox(
                  height: 10,
                ),
                postedJob.isEmpty
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 12),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 17,
                        ),
                        width: width,
                        height: height / 18,
                        decoration: BoxDecoration(
                            color: Colors.orangeAccent.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: Text(
                            textAlign: TextAlign.center,
                            "Popular tags are not available.",
                            style: GoogleFonts.lato(
                              color: Colors.orangeAccent,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                    : Container(
                        width: width,
                        height: height / 18,
                        // color: Colors.orangeAccent,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(left: 17),
                          physics: const BouncingScrollPhysics(),
                          itemCount: type.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return ConstrainedBox(
                              constraints: const BoxConstraints(
                                // maxWidth: 150,
                                minWidth: 50,
                              ),
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                height: height / 20,
                                decoration: BoxDecoration(
                                    color: Colors.orangeAccent,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    type[index],
                                    style: GoogleFonts.lato(
                                      color: KColors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 17.0),
                  child: Text(
                    "Recommended For You",
                    style: GoogleFonts.lato(
                      color: KColors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: postedJob.isEmpty
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 12),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 17, vertical: 12),
                          width: width,
                          height: double.maxFinite,
                          decoration: BoxDecoration(
                              color: Colors.orangeAccent.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            child: Text(
                              textAlign: TextAlign.center,
                              "No jobs posted. Please check back later.",
                              style: GoogleFonts.lato(
                                color: Colors.orangeAccent,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.only(
                            top: 10,
                          ),
                          width: width,
                          height: double.maxFinite,
                          child: LiquidPullToRefresh(
                            height: 100,
                            backgroundColor: Colors.orangeAccent,
                            color: Colors.orangeAccent.withOpacity(0.7),
                            onRefresh: getAllJobs,
                            child: ListView.builder(
                              padding: const EdgeInsets.only(top: 10),
                              physics: const BouncingScrollPhysics(),
                              itemCount: postedJob.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 17),
                                  child: RecommondWidget(
                                    element: postedJob[index],
                                    index: index,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
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
