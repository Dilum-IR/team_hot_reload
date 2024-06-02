import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hot_reload/components/widget/comman_widget/space.dart';
import 'package:hot_reload/utils/constraints/colors.dart';
import 'package:hot_reload/utils/helper/device.dart';

import '../../../../components/style/app_input_style.dart';
import '../../../../components/style/text_styles.dart';
import '../../../../components/widget/comman_widget/alert_popup.dart';
import '../../../../utils/helper/event_handler.dart';
import 'add_skills.dart';
import 'create_event_3.dart';

class CreateEvent2 extends StatefulWidget {
  const CreateEvent2({Key? key}) : super(key: key);

  @override
  State<CreateEvent2> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent2> {
  var _age_value = 'Age Restrictions';

  List<String> _ageNew = [
    'Age Restrictions',
    "18",
    "25",
    "30",
    "40",
  ];

  @override
  void initState() {
    // print(EventHandler.longitude);
    // print(EventHandler.location);
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        radius: 7,
                        backgroundColor: KColors.primary,
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      CircleAvatar(
                        radius: 5,
                        backgroundColor: Colors.black45,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                KH18Space(),
                KH12Space(),
                TextField(
                  controller: noVolunteersController,
                  decoration: InputDecoration(
                    border: AppInputStyle.outlineInputBorder,
                    focusedBorder: AppInputStyle.outlineInputBorder,
                    contentPadding: AppInputStyle.contentPadding,
                    // filled: validRepassword ? true : false,
                    fillColor: AppInputStyle.validFillColor,
                    // hintText: "Number Of Volunteers Needed",
                    labelText: "Number Of Volunteers Needed",
                    hintStyle: KTextStyles.smallerGText,
                    isDense: true,
                    labelStyle: KTextStyles.smallerBText,
                    floatingLabelStyle: KTextStyles.blackXlText,
                    // prefixIcon: AppInputStyle.passwordIcon,
                  ),
                  keyboardType: TextInputType.number,
                ),
                KH12Space(),
                TextField(
                  controller: skillsController,
                  decoration: InputDecoration(
                      border: AppInputStyle.outlineInputBorder,
                      focusedBorder: AppInputStyle.outlineInputBorder,
                      contentPadding: AppInputStyle.contentPadding,
                      // filled: validRepassword ? true : false,
                      fillColor: AppInputStyle.validFillColor,
                      // hintText: "Number Of Volunteers Needed",
                      labelText: "Skills",
                      hintStyle: KTextStyles.smallerGText,
                      isDense: true,
                      labelStyle: KTextStyles.smallerBText,
                      floatingLabelStyle: KTextStyles.blackXlText,
                      // prefixIcon: AppInputStyle.passwordIcon,
                      suffixIcon: IconButton(
                        onPressed: () {
                          dialog(context, "desc", () {
                            setState(() {});
                          });
                        },
                        icon: Icon(
                          Icons.coronavirus_outlined,
                          color: KColors.primary,
                        ),
                      )),
                  // keyboardType: TextInputType.number,
                  // readOnly: true,
                ),
                KH12Space(),
                Text("Set Age Range", style: KTextStyles.smallerBText),
                KH12Space(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 45,
                      width: width - 220,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xffeeeeee),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextField(
                        cursorColor: Colors.black,
                        cursorHeight: 20,
                        controller: minAgeController,
                        keyboardType: TextInputType.number,
                        // onChanged: (search) => onSearchChanged(search),
                        decoration: InputDecoration(
                          border: AppInputStyle.outlineInputBorder,
                          focusedBorder: AppInputStyle.outlineInputBorder,
                          fillColor: Colors.white,
                          filled: true,
                          // hintText: "Min Age",
                          labelText: "Min Age",
                          hintStyle: KTextStyles.smallerGText,
                          labelStyle: KTextStyles.smallerBText,
                          floatingLabelStyle: KTextStyles.blackXlText,
                          prefixIcon: Icon(
                            Icons.accessibility,
                            size: 20,
                            color: KColors.primary,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: width - 220,
                      height: 45,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xffeeeeee),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextField(
                        cursorColor: Colors.black,
                        cursorHeight: 20,
                        keyboardType: TextInputType.number,
                        controller: maxAgeController,
                        // onChanged: (search) => onSearchChanged(search),
                        decoration: InputDecoration(
                          border: AppInputStyle.outlineInputBorder,
                          focusedBorder: AppInputStyle.outlineInputBorder,
                          fillColor: Colors.white,
                          filled: true,
                          // hintText: "Max Age",
                          labelText: "Max Age",
                          hintStyle: KTextStyles.smallerGText,
                          labelStyle: KTextStyles.smallerBText,
                          floatingLabelStyle: KTextStyles.blackXlText,
                          prefixIcon: Icon(
                            Icons.accessibility,
                            size: 20,
                            color: KColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                KH18Space(),
                TextField(
                  cursorColor: Colors.black,
                  cursorHeight: 20,
                  controller: deadLineController,
                  decoration: InputDecoration(
                    border: AppInputStyle.outlineInputBorder,
                    focusedBorder: AppInputStyle.outlineInputBorder,
                    contentPadding: AppInputStyle.contentPadding,
                    // filled: validRepassword ? true : false,
                    fillColor: AppInputStyle.validFillColor,
                    hintText: "DD/MM/YYYY",
                    labelText: "Registration Deadline",
                    hintStyle: KTextStyles.smallerGText,
                    labelStyle: KTextStyles.smallerBText,
                    floatingLabelStyle: KTextStyles.blackXlText,
                    // prefixIcon: AppInputStyle.passwordIcon,
                  ),
                  onTap: () {
                    _selectDate(true);
                  },
                  readOnly: true,
                ),
                KH12Space(),
                TextField(
                  cursorColor: Colors.black,
                  cursorHeight: 20,
                  maxLines: 7,
                  controller: noteController,
                  // onChanged: (search) => onSearchChanged(search),
                  decoration: InputDecoration(
                    border: AppInputStyle.outlineInputBorder,
                    focusedBorder: AppInputStyle.outlineInputBorder,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 17,
                      vertical: 20,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "add a Note",
                    labelText: "Notes",
                    hintStyle: KTextStyles.smallerGText,
                    labelStyle: KTextStyles.smallerBText,
                    floatingLabelStyle: KTextStyles.blackXlText,
                    alignLabelWithHint: true,
                    // prefixIcon: AppInputStyle.passwordIcon,
                  ),
                ),
                KH12Space(),
                KH18Space(),
                KH18Space(),
                KH18Space(),
                KH18Space(),
                // Expanded(child: Container()),
                MaterialButton(
                  animationDuration: const Duration(milliseconds: 10000),
                  height: 50,
                  minWidth: double.infinity,
                  disabledColor: Colors.black54,
                  onPressed: _validData()
                      ? () {
                          saveUserData();
                        }
                      : null,
                  color: Colors.black87,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text(
                    "Next",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                KH12Space()
              ],
            ),
          ),
        ));
  }

  TextEditingController noVolunteersController = TextEditingController();
  TextEditingController deadLineController = TextEditingController();
  TextEditingController skillsController = TextEditingController();
  TextEditingController minAgeController = TextEditingController();
  TextEditingController maxAgeController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  late dynamic _startDate;
  late dynamic _endDate;

  bool _validData() {
    if (deadLineController.text.trim().isNotEmpty &&
        minAgeController.text.trim().isNotEmpty &&
        maxAgeController.text.trim().isNotEmpty &&
        noVolunteersController.text.trim().isNotEmpty) {
      setState(() {});
      return true;
    } else
      setState(() {});
    return false;
  }

  void saveUserData() {
    if (int.parse(noVolunteersController.text.trim().toString()) < 1) {
      AlertPopup.warning(
        title: "Invalid Number of Volunteers",
        message: "There must be at least one Volunteers",
        type: 2,
      );
      return;
    }
    if (int.parse(minAgeController.text.trim().toString()) < 16) {
      AlertPopup.warning(
        title: "Invalid Age",
        message: "minimum age should be 16 years",
        type: 2,
      );
      return;
    }
    if (int.parse(minAgeController.text.trim().toString()) >
        int.parse(maxAgeController.text.trim().toString())) {
      AlertPopup.warning(
        title: "Invalid Age",
        message: "Max age should be less than min age!",
        type: 2,
      );
      return;
    }

    if (!DateTime.parse(EventHandler.startDate).isAfter(_startDate)) {
      AlertPopup.warning(
        title: "Oops! Date are Invalid",
        message: "Selected Deadline is invalid.",
        type: 2,
      );
      return;
    }

    EventHandler.numberOfVolunteersNeeded = noVolunteersController.text.trim();
    EventHandler.skills = skillList;
    EventHandler.minAge = minAgeController.text.trim();
    EventHandler.maxAge = maxAgeController.text.trim();
    EventHandler.deadline = deadLineController.text.trim();
    EventHandler.notes =
        noteController.text.trim() == "" ? "" : noteController.text.trim();

    Get.to(() => CreateEvent3());
  }

  Future<void> _selectDate(bool type) async {
    DateTime? _pickDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );

    if (_pickDate != null) {
      if (type) {
        _startDate = _pickDate;
        deadLineController.text = _pickDate.toString().split(" ")[0];
      }
      setState(() {});
    }
  }

  var _industry_value = 'Skills';

  List<String> _industryNew = [
    "Skills",
    "Communication",
    "Time Management",
    "Adaptability",
    "Problem Solving",
    "Team Work",
  ];

  List<String> skillList = [];

  void dialog(BuildContext context, String desc, Function onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Add Event Skills",
            style: GoogleFonts.lato(color: Colors.black),
          ),
          content: DropdownButtonFormField(
            icon: AppInputStyle.dropDownIcon,
            menuMaxHeight: 200,
            alignment: Alignment.bottomCenter,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.history_edu,
                color: KColors.primary,
                size: 25,
              ),
              contentPadding: EdgeInsets.only(
                top: 25,
                left: 10,
                right: 10,
              ),
              border: AppInputStyle.outlineInputBorder,
              focusedBorder: AppInputStyle.outlineInputBorder,
              enabledBorder: AppInputStyle.outlineInputBorder,
              enabled: true,
            ),
            value: _industry_value,
            items: _industryNew
                .map((item) => DropdownMenuItem<String>(
                      // alignment: Alignment.center,
                      // enabled: true,
                      child: Text(item),
                      value: item,
                    ))
                .toList(),
            onChanged: (item) {
              _industry_value = item!;

              onConfirm();
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.black45),
              child:
                  Text("Back", style: GoogleFonts.lato(color: Colors.black87)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                if (skillsController.text != "") {
                  skillsController.text += _industry_value! + ",";
                  skillList.add(_industry_value!);
                } else {
                  skillList = [];
                  skillsController.text = _industry_value! + ",";
                  skillList.add(_industry_value!);
                }
                onConfirm(); // Call the callback function to handle dismissal
              },
              child: Text(
                "Confirm",
                style: GoogleFonts.lato(),
              ),
            ),
          ],
        );
      },
    );
  }
}
