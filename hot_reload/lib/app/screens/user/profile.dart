import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hot_reload/components/widget/comman_widget/alert_popup.dart';
import 'package:hot_reload/utils/constraints/texts.dart';
import '../../../components/widget/upload_progress.dart';
import '../../../utils/constraints/colors.dart';
import '../../../utils/helper/device.dart';
import '../../../utils/helper/user_handler.dart';
import '../../controllers/user/shared_auth_user.dart';
import '../../controllers/user/user_feature_controller.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    // var height = KDeviceUtils.getHeight(context);
    var width = KDeviceUtils.getWidth(context);

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            splashRadius: 20,
            onPressed: () {},
            icon: const Icon(
              Icons.share,
              color: KColors.black,
              size: 30,
            ),
          ),
          IconButton(
            splashRadius: 20,
            onPressed: () {},
            icon: const Icon(
              Icons.settings,
              color: KColors.black,
              size: 30,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.only(left: 17, right: 17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Column(
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 63,
                            backgroundColor: KColors.black,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: KColors.white,
                              child: CircleAvatar(
                                radius: 57,
                                backgroundColor:
                                    Colors.orangeAccent.withOpacity(0.3),
                                child: pickerFile == null
                                    ? CachedNetworkImage(
                                        imageUrl:
                                            SharedAuthUser.getimageUrl() ??
                                                KTexts.profileImg,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          width: 110,
                                          height: 110,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: imageProvider,
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) =>
                                            Container(
                                          alignment: Alignment.center,
                                          child:
                                              const CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        width: 110,
                                        height: 110,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(
                                              File(pickerFile!.path!),
                                            ),
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Hi, $name",
                      style: GoogleFonts.lato(
                        color: KColors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 115, right: 115),
                      child: MaterialButton(
                        animationDuration: const Duration(milliseconds: 10000),
                        height: 40,
                        minWidth: width,
                        disabledColor: Colors.black45,
                        onPressed: () {
                          uploadImage();
                        },
                        color: Colors.black87,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Edit Profile",
                              style: GoogleFonts.lato(color: Colors.white),
                            ),
                            const Icon(
                              Icons.edit,
                              color: KColors.white,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    UploadFileProgress(
                      uploadTask: uploadTask,
                      height: 3,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          // todo: About me
                          Container(
                            width: width,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withAlpha(30),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                )
                              ],
                            ),
                            child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                    left: 15,
                                  ),
                                  child: Row(
                                    // crossAxisAlignment: CrossAxisAlignment.baseline,
                                    // textBaseline: TextBaseline.ideographic,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Icon(
                                        Icons.person_outlined,
                                        color: Colors.orangeAccent,
                                        size: 25,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "About me",
                                        style: GoogleFonts.lato(
                                          color: KColors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                    right: 15,
                                  ),
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.orangeAccent,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: IconButton(
                                    padding: const EdgeInsets.only(left: 0),
                                    splashColor: Colors.orangeAccent.shade100,
                                    splashRadius: 30,
                                    onPressed: () async {
                                      // var res = await Get.to(
                                      //   () => const AboutMe(),
                                      //   transition: Transition.rightToLeft,
                                      //   duration: const Duration(
                                      //     milliseconds: 1000,
                                      //   ),
                                      // );
                                      // if (mounted) {
                                      //   setState(() {
                                      //     name = res;
                                      //   });
                                      // }
                                    },
                                    icon: const Icon(
                                      Icons.add,
                                      color: KColors.white,
                                      size: 18,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // todo: Work Experience
                          Container(
                            width: width,
                            height: 70,
                            decoration: BoxDecoration(
                              color: KColors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withAlpha(30),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                )
                              ],
                            ),
                            child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                    left: 15,
                                  ),
                                  child: Row(
                                    // crossAxisAlignment: CrossAxisAlignment.baseline,
                                    // textBaseline: TextBaseline.ideographic,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Icon(
                                        Icons.work_outline_rounded,
                                        color: Colors.orangeAccent,
                                        size: 25,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "Work Experience",
                                        style: GoogleFonts.lato(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                    right: 15,
                                  ),
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.orangeAccent,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: IconButton(
                                    padding: const EdgeInsets.only(left: 0),
                                    splashColor: Colors.orangeAccent.shade100,
                                    splashRadius: 30,
                                    onPressed: () {
                                      // Get.to(
                                      //   () => AddWorkExperince(),
                                      //   transition: Transition.rightToLeft,
                                      //   duration: const Duration(
                                      //     milliseconds: 1000,
                                      //   ),
                                      // );
                                    },
                                    icon: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // todo: Education
                          Container(
                            width: width,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withAlpha(30),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                )
                              ],
                            ),
                            child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                    left: 15,
                                  ),
                                  child: Row(
                                    // crossAxisAlignment: CrossAxisAlignment.baseline,
                                    // textBaseline: TextBaseline.ideographic,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Icon(
                                        Icons.leaderboard_outlined,
                                        color: Colors.orangeAccent,
                                        size: 25,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "Education",
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                    right: 15,
                                  ),
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.orangeAccent,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: IconButton(
                                    padding: const EdgeInsets.only(left: 0),
                                    splashColor: Colors.orangeAccent.shade100,
                                    splashRadius: 30,
                                    onPressed: () {
                                      // Get.to(
                                      //   () => AddEducation(),
                                      //   transition: Transition.rightToLeft,
                                      //   duration: Duration(
                                      //     milliseconds: 1000,
                                      //   ),
                                      // );
                                    },
                                    icon: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // todo: Skill
                          Container(
                            width: width,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withAlpha(30),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                )
                              ],
                            ),
                            child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                    left: 15,
                                  ),
                                  child: Row(
                                    // crossAxisAlignment: CrossAxisAlignment.baseline,
                                    // textBaseline: TextBaseline.ideographic,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Icon(
                                        Icons.coronavirus,
                                        color: Colors.orangeAccent,
                                        size: 25,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "Skill",
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                    right: 15,
                                  ),
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.orangeAccent,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: IconButton(
                                    padding: const EdgeInsets.only(left: 0),
                                    splashColor: Colors.orangeAccent.shade100,
                                    splashRadius: 30,
                                    onPressed: () {
                                      // Get.to(
                                      //   () => AddSkills(),
                                      //   transition: Transition.rightToLeft,
                                      //   duration: Duration(
                                      //     milliseconds: 1000,
                                      //   ),
                                      // );
                                    },
                                    icon: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // todo: Qualification
                          Container(
                            width: width,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withAlpha(30),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                )
                              ],
                            ),
                            child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                    left: 15,
                                  ),
                                  child: Row(
                                    // crossAxisAlignment: CrossAxisAlignment.baseline,
                                    // textBaseline: TextBaseline.ideographic,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Icon(
                                        Icons.workspace_premium_rounded,
                                        color: Colors.orangeAccent,
                                        size: 25,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "Qualification",
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                    right: 15,
                                  ),
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.orangeAccent,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: IconButton(
                                    padding: const EdgeInsets.only(left: 0),
                                    splashColor: Colors.orangeAccent.shade100,
                                    splashRadius: 30,
                                    onPressed: () {
                                      // Get.to(
                                      //   () => AddQualification(),
                                      //   transition: Transition.rightToLeft,
                                      //   duration: Duration(
                                      //     milliseconds: 1000,
                                      //   ),
                                      // );
                                    },
                                    icon: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  var name = "";

  @override
  void initState() {
    setState(() {
      name = SharedAuthUser.getAuthUser()[3];
    });
    super.initState();
  }

  late var fileName;
  PlatformFile? pickerFile;
  UploadTask? uploadTask;

  Future uploadImage() async {
    final select_file = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: ['jpg', 'png']);
    if (select_file == null) return;
    // pickerFile!.name = UserHandler.email;
    setState(() {
      pickerFile = select_file.files.first;
    });
    uploadFile();
  }

  late var imageUrl;
  final controller = Get.put(UserFeatureController());

  Future uploadFile() async {
    final path = "user_images/${UserHandler.email + "_" + pickerFile!.name}";
    final file = File(pickerFile!.path!);

    final refe = FirebaseStorage.instance.ref().child(path);

    setState(() {
      uploadTask = refe.putFile(file);
    });
    final snapshot = await uploadTask!.whenComplete(() {
      Future.delayed(const Duration(seconds: 1));
      AlertPopup.warning(
        title: "Update Successful 🎉",
        message: "Your profile image added.",
      );
    });

    imageUrl = await snapshot.ref.getDownloadURL();
    SharedAuthUser.saveimageUrl(imageUrl);

    controller.saveImageUrl(imageUrl);
    // print(imageUrl);

    setState(() {
      uploadTask = null;
    });
  }
}
