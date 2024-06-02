import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hot_reload/components/style/text_styles.dart';
import 'package:hot_reload/components/widget/comman_widget/alert_popup.dart';
import 'package:hot_reload/components/widget/comman_widget/space.dart';
import 'package:hot_reload/utils/constraints/texts.dart';
import '../../../components/widget/comman_widget/show_confirm.dart';
import '../../../components/widget/upload_progress.dart';
import '../../../utils/constraints/colors.dart';
import '../../../utils/helper/device.dart';
import '../../../utils/helper/user_handler.dart';
import '../../controllers/user/shared_auth_user.dart';
import '../../controllers/user/user_feature_controller.dart';
import '../../controllers/user/user_signup_controller.dart';

class OrganizerProfile extends StatefulWidget {
  const OrganizerProfile({super.key});

  @override
  State<OrganizerProfile> createState() => Oorganizer_profPeState();
}

class Oorganizer_profPeState extends State<OrganizerProfile> {
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
              Icons.edit,
              color: KColors.black,
              size: 30,
            ),
          ),
          IconButton(
            splashRadius: 20,
            onPressed: () {},
            icon: const Icon(
              Icons.share,
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
                      "${UserHandler.capitalizeFirstLetter(name)}",
                      style: GoogleFonts.lato(
                        color: KColors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "$email",
                      style: GoogleFonts.lato(
                        color: KColors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 98, right: 98),
                      child: MaterialButton(
                        animationDuration: const Duration(milliseconds: 10000),
                        height: 40,
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
                              "Edit Profile Image",
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
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  '1.3 K',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text('Events'),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '5.7 K',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text('Followers'),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '128',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text('Following'),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        SwitchListTile(
                          title: Text('Available'),
                          value: is_available,
                          onChanged: (bool value) {
                            is_available = !is_available;
                            if (mounted) {
                              setState(() {});
                            }

                            available();
                          },
                        ),
                        SwitchListTile(
                          title: Text('Notifications'),
                          value: is_notifications,
                          onChanged: (bool value) {
                            is_notifications = !is_notifications;
                            if (mounted) {
                              setState(() {});
                            }
                          },
                        ),
                        ListTile(
                          title: Text('Impact Statistics'),
                          trailing: Icon(Icons.chevron_right),
                          onTap: () {},
                        ),
                        ListTile(
                          title: Text('Certifications'),
                          trailing: Icon(Icons.chevron_right),
                          onTap: () {},
                        ),
                        ListTile(
                          title: Text('Feedbacks'),
                          trailing: Icon(Icons.chevron_right),
                          onTap: () {},
                        ),
                        KH18Space(),
                        KH18Space(),
                        ElevatedButton(
                          onPressed: () {
                            ShowConfirm.dialog(
                                context, "Do You Want to Logout ?", () {
                              userController.logoutUser();
                            });
                          },
                          child: Text('Logout', style: KTextStyles.mediumWText),
                          style: ElevatedButton.styleFrom(
                            primary: KColors.error,
                            padding: EdgeInsets.symmetric(
                                horizontal: 100, vertical: 15),
                            textStyle: TextStyle(fontSize: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
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
  var email = "";

  bool is_available = false;
  bool is_notifications = false;

  final userController = Get.put(UserSignUpController());
  final userFeatureController = Get.put(UserFeatureController());

  @override
  void initState() {
    setState(() {
      name = SharedAuthUser.getAuthUser()[3];
      email = SharedAuthUser.getAuthUser()[2];
      is_available = SharedAuthUser.getAuthUser()[4] == "true" ? true : false;
    });
    super.initState();
  }

  void available() {
    print(is_available);

    Map<String, dynamic> data = {
      "id": SharedAuthUser.getAuthUser()[0],
      "isAvailable": is_available
    };
    userFeatureController.changeAvailable(data);
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

    controller.saveImageUrl(imageUrl);
    // print(imageUrl);

    setState(() {
      SharedAuthUser.saveimageUrl(imageUrl);
      uploadTask = null;
    });
  }
}
