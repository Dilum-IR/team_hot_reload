import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hot_reload/app/controllers/user/user_feature_controller.dart';
import 'package:hot_reload/app/model/event_model.dart';
import 'package:hot_reload/app/screens/organizer/organizer_home_screen.dart';
import 'package:hot_reload/components/widget/comman_widget/custom_image.dart';
import 'package:hot_reload/utils/helper/event_handler.dart';
import 'package:dotted_border/dotted_border.dart';

import '../../../../components/style/app_input_style.dart';
import '../../../../components/style/text_styles.dart';
import '../../../../components/widget/comman_widget/alert_popup.dart';
import '../../../../components/widget/comman_widget/space.dart';
import '../../../../components/widget/upload_progress.dart';
import '../../../../utils/constraints/colors.dart';
import '../../../../utils/helper/device.dart';
import '../../../../utils/helper/user_handler.dart';

class CreateEvent3 extends StatefulWidget {
  const CreateEvent3({Key? key}) : super(key: key);

  @override
  State<CreateEvent3> createState() => _CreateEvent3State();
}

class _CreateEvent3State extends State<CreateEvent3> {
  @override
  void initState() {
    print(EventHandler.skills);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = KDeviceUtils.getWidth(context);
    var height = KDeviceUtils.getHeight(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: KColors.white,
        title: Text("Create Event", style: KTextStyles.largeBText),
        centerTitle: true,
        leading: IconButton(
          splashRadius: 20,
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
            size: 30,
          ),
        ),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: BouncingScrollPhysics(),
        child: Container(
          height: height,
          padding: EdgeInsets.symmetric(horizontal: 17),
          child: Column(
            children: [
              KH18Space(),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 5,
                      backgroundColor: Colors.black45,
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    CircleAvatar(
                      radius: 5,
                      backgroundColor: Colors.black45,
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    CircleAvatar(
                      radius: 5,
                      backgroundColor: Colors.black45,
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    CircleAvatar(
                      radius: 7,
                      backgroundColor: KColors.primary,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              KH12Space(),
              KH18Space(),
              DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(12),
                padding: EdgeInsets.all(6),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: GestureDetector(
                    onTap: () {
                      // todo: photo upload
                      selectFile();
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      height: 350,
                      width: width,
                      // color: Colors.amber,
                      child: imageUrls.isNotEmpty
                          ? Center(
                              child: ListView.builder(
                                itemCount: imageUrls.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: CustomImage(
                                      radius: 5,
                                      image: imageUrls[index],
                                      size: 200,
                                      type: BoxFit.fill,
                                      // pickerFile!.name,
                                      // style: TextStyle(
                                      //   // fontWeight: FontWeight.w500,
                                      //   fontSize: 16,
                                      // ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.backup_outlined,
                                  color: KColors.primary,
                                  size: 35,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Upload photos and videos",
                                  style: TextStyle(
                                    // fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ),
              KH18Space(),
              UploadFileProgress(
                uploadTask: uploadTask,
                height: 30.0,
              ),
              KH18Space(),
              TextField(
                controller: tagsController,
                decoration: InputDecoration(
                  border: AppInputStyle.outlineInputBorder,
                  focusedBorder: AppInputStyle.outlineInputBorder,
                  contentPadding: AppInputStyle.contentPadding,
                  // filled: validRepassword ? true : false,
                  fillColor: AppInputStyle.validFillColor,
                  hintText: "Add Your Tags By Comma Separated",
                  labelText: "Add Tags",
                  hintStyle: KTextStyles.smallerGText,
                  labelStyle: KTextStyles.smallerBText,
                  floatingLabelStyle: KTextStyles.blackXlText,
                  // prefixIcon: AppInputStyle.passwordIcon,
                ),
              ),
              KH12Space(),
              KH12Space(),
              MaterialButton(
                animationDuration: const Duration(milliseconds: 10000),
                height: 50,
                minWidth: double.infinity,
                disabledColor: Colors.black54,
                onPressed: _validData()
                    ? () {
                        saveUserData();

                        if (mounted) {
                          is_loading = !is_loading;

                          setState(() {});
                        }
                      }
                    : null,
                color: Colors.black87,
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10)),
                child: is_loading
                    ? CircularProgressIndicator(
                        color: KColors.primary,
                      )
                    : Text(
                        "Create",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool is_loading = false;

  TextEditingController tagsController = TextEditingController();

  bool _validData() {
    if (tagsController.text.trim().isNotEmpty && imageUrls.isNotEmpty) {
      return true;
    } else
      return false;
  }

  late var fileName;
  PlatformFile? pickerFile;
  UploadTask? uploadTask;
  late var imageUrls = [];

  Future selectFile() async {
    final select_file = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: ['jpg', 'pdf', 'doc']);
    if (select_file == null) return;
    // pickerFile!.name = UserHandler.email;
    setState(() {
      pickerFile = select_file.files.first;
    });
    uploadFile();
  }

  Future uploadFile() async {
    final path = "event_data/${UserHandler.email + "_" + pickerFile!.name}";
    final file = File(pickerFile!.path!);

    final refe = FirebaseStorage.instance.ref().child(path);

    setState(() {
      uploadTask = refe.putFile(file);
    });
    final snapshot = await uploadTask!.whenComplete(() {
      Future.delayed(Duration(seconds: 1));
      AlertPopup.warning(
        title: "Uploading Successful 🎉",
        message: "Your Event photos and videos added.",
      );
      Get.back();
    });

    var imageUrl = await snapshot.ref.getDownloadURL();
    imageUrls.add(imageUrl);

    // print(imageUrls);

    setState(() {
      uploadTask = null;
    });
  }

  final userController = Get.put(UserFeatureController());

  void saveUserData() {
    EventHandler.imageUrl = imageUrls;
    EventHandler.tags = tagsController.text.trim().toString().split(",");

    EventModel data = EventModel.create(
      name: EventHandler.name,
      description: EventHandler.description,
      causeArea: EventHandler.causeArea,
      startDate: EventHandler.startDate,
      endDate: EventHandler.endDate,
      startTime: EventHandler.startTime,
      contactNumber: EventHandler.contactNumber,
      contactEmail: EventHandler.contactEmail,
      location: EventHandler.location,
      latitude: EventHandler.latitude,
      longitude: EventHandler.longitude,
      numberOfVolunteersNeeded:
          int.parse(EventHandler.numberOfVolunteersNeeded),
      skills: List<String>.from(EventHandler.skills),
      minAge: int.parse(EventHandler.minAge),
      maxAge: int.parse(EventHandler.maxAge),
      deadline: EventHandler.deadline,
      imageUrl: List<String>.from(EventHandler.imageUrl),
      organizerId: UserHandler.id,
      applicants: <String>[],
      volunteers: <String>[],
      notes: EventHandler.notes,
      // Ensure notes is List<String>
      tags: List<String>.from(EventHandler.tags),
    );
    userController.saveEvent(data);
    Get.offAll(
      () => OrganizerHomeScreen(),
      duration: Duration(seconds: 1),
      transition: Transition.fadeIn,
    );
    Future.delayed(Duration(seconds: 4), () {
      if (mounted) {
        is_loading = !is_loading;
        setState(() {});
      }
    });
  }
}
