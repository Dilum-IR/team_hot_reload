import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hot_reload/components/widget/comman_widget/space.dart';
import 'package:hot_reload/utils/constraints/colors.dart';
import 'package:hot_reload/utils/helper/device.dart';
import 'package:hot_reload/utils/helper/event_handler.dart';
import 'package:hot_reload/utils/helper/user_handler.dart';

import '../../../../components/style/app_input_style.dart';
import '../../../../components/style/text_styles.dart';
import '../../../../components/widget/comman_widget/alert_popup.dart';
import 'add_location.dart';
import 'create_event_2.dart';

class CreateEvent1 extends StatefulWidget {
  const CreateEvent1({Key? key}) : super(key: key);

  @override
  State<CreateEvent1> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent1> {
  var _industry_value = 'Cause Area';

  List<String> _industryNew = [
    "Cause Area",
    "Education",
    "Children",
    "Health",
    "Disability",
    "Environment"
  ];

  @override
  void initState() {
    // TODO: implement initState
    eventEmailController.text = UserHandler.email;
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
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                KH18Space(),
                KH12Space(),
                TextField(
                  controller: eventNameController,
                  decoration: InputDecoration(
                    border: AppInputStyle.outlineInputBorder,
                    focusedBorder: AppInputStyle.outlineInputBorder,
                    contentPadding: AppInputStyle.contentPadding,
                    // filled: validRepassword ? true : false,
                    fillColor: AppInputStyle.validFillColor,
                    hintText: "Enter Your Event Name",
                    labelText: "Event Name",
                    hintStyle: KTextStyles.smallerGText,
                    labelStyle: KTextStyles.smallerBText,
                    floatingLabelStyle: KTextStyles.blackXlText,
                    // prefixIcon: AppInputStyle.passwordIcon,
                  ),
                ),
                KH12Space(),
                DropdownButtonFormField(
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
                    setState(() {
                      _industry_value = item!;
                    });
                  },
                ),
                KH12Space(),
                TextField(
                  cursorColor: Colors.black,
                  cursorHeight: 20,
                  maxLines: 7,
                  controller: descriptionController,
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
                    hintText: "type your Description",
                    labelText: "Description",
                    hintStyle: KTextStyles.smallerGText,
                    labelStyle: KTextStyles.smallerBText,
                    floatingLabelStyle: KTextStyles.blackXlText,
                    alignLabelWithHint: true,
                    // prefixIcon: AppInputStyle.passwordIcon,
                  ),
                ),
                KH12Space(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 50,
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
                        controller: startDateController,
                        // onChanged: (search) => onSearchChanged(search),
                        decoration: InputDecoration(
                          border: AppInputStyle.outlineInputBorder,
                          focusedBorder: AppInputStyle.outlineInputBorder,
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "DD/MM/YYYY",
                          labelText: "Start Date",
                          hintStyle: KTextStyles.smallerGText,
                          labelStyle: KTextStyles.smallerBText,
                          floatingLabelStyle: KTextStyles.blackXlText,
                          prefixIcon: Icon(
                            Icons.date_range,
                            size: 20,
                            color: KColors.primary,
                          ),
                        ),
                        onTap: () {
                          _selectDate(true);
                        },
                      ),
                    ),
                    Container(
                      width: width - 220,
                      height: 50,
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
                        controller: endDateController,
                        // onChanged: (search) => onSearchChanged(search),
                        decoration: InputDecoration(
                          border: AppInputStyle.outlineInputBorder,
                          focusedBorder: AppInputStyle.outlineInputBorder,
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "DD/MM/YYYY",
                          labelText: "End Date",
                          hintStyle: KTextStyles.smallerGText,
                          labelStyle: KTextStyles.smallerBText,
                          floatingLabelStyle: KTextStyles.blackXlText,
                          prefixIcon: Icon(
                            Icons.date_range,
                            size: 20,
                            color: KColors.primary,
                          ),
                        ),
                        onTap: () {
                          _selectDate(false);
                        },
                      ),
                    ),
                  ],
                ),
                KH12Space(),
                TextField(
                  readOnly: true,
                  controller: eventTimeController,
                  decoration: InputDecoration(
                    border: AppInputStyle.outlineInputBorder,
                    focusedBorder: AppInputStyle.outlineInputBorder,
                    contentPadding: AppInputStyle.contentPadding,
                    // filled: validRepassword ? true : false,
                    fillColor: AppInputStyle.validFillColor,
                    hintText: "Start Time",
                    labelText: "Start Time",
                    hintStyle: KTextStyles.smallerGText,
                    labelStyle: KTextStyles.smallerBText,
                    floatingLabelStyle: KTextStyles.blackXlText,
                    prefixIcon: Icon(
                      Icons.timelapse,
                      size: 20,
                      color: KColors.primary,
                    ),
                  ),
                  onTap: () {
                    selectTimePopup();
                    // if (mounted) {
                    //   setState(() {
                    //     eventTimeController.text = availableTimes[0];
                    //   });
                    // }
                    //
                  },
                ),
                KH12Space(),
                TextField(
                  controller: eventNumberController,
                  // maxLength: 10,
                  inputFormatters: [FilteringTextInputFormatter.allow(_regex)],
                  decoration: InputDecoration(
                    border: AppInputStyle.outlineInputBorder,
                    focusedBorder: AppInputStyle.outlineInputBorder,
                    contentPadding: AppInputStyle.contentPadding,
                    // filled: validRepassword ? true : false,
                    fillColor: AppInputStyle.validFillColor,
                    hintText: "Enter Your Contact Number",
                    labelText: "Contact Number",
                    hintStyle: KTextStyles.smallerGText,
                    labelStyle: KTextStyles.smallerBText,
                    floatingLabelStyle: KTextStyles.blackXlText,
                    prefixIcon: Icon(
                      Icons.phone,
                      size: 20,
                      color: KColors.primary,
                    ),
                  ),
                ),
                KH12Space(),
                TextField(
                  controller: eventEmailController,
                  decoration: InputDecoration(
                    border: AppInputStyle.outlineInputBorder,
                    focusedBorder: AppInputStyle.outlineInputBorder,
                    contentPadding: AppInputStyle.contentPadding,
                    // filled: validRepassword ? true : false,
                    fillColor: AppInputStyle.validFillColor,
                    hintText: "Enter Your Contact Email",
                    labelText: "Contact Email",
                    hintStyle: KTextStyles.smallerGText,
                    labelStyle: KTextStyles.smallerBText,
                    floatingLabelStyle: KTextStyles.blackXlText,
                    prefixIcon: Icon(
                      Icons.email,
                      size: 20,
                      color: KColors.primary,
                    ),
                  ),
                ),
                KH12Space(),

                // Expanded(
                //     child: Container(
                //   height: 150,
                // )),
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
                KH12Space(),
              ],
            ),
          ),
        ));
  }

  // Regex to allow up to 10 characters
  final RegExp _regex = RegExp(r'^.{0,10}$');

  TextEditingController eventNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController eventTimeController = TextEditingController();
  TextEditingController eventNumberController = TextEditingController();
  TextEditingController eventEmailController = TextEditingController();

  late dynamic _startDate;
  late dynamic _endDate;

  bool _validData() {
    if (startDateController.text.trim().isNotEmpty &&
        endDateController.text.trim().isNotEmpty &&
        eventEmailController.text.trim().isNotEmpty &&
        descriptionController.text.trim().isNotEmpty &&
        eventNameController.text.trim().isNotEmpty &&
        eventTimeController.text.trim().isNotEmpty &&
        _industry_value != "Course Area") {
      return true;
    } else
      return false;
  }

  void saveUserData() {
    if (!_endDate.isAfter(_startDate)) {
      AlertPopup.warning(
        title: "Dates are Invalid",
        message: "Please Select Valid EndDate.",
        type: 2,
      );
      return;
    }

    EventHandler.name = eventNameController.text.trim();
    EventHandler.description = descriptionController.text.trim();
    EventHandler.startDate = startDateController.text.trim();
    EventHandler.endDate = endDateController.text.trim();
    EventHandler.startTime = eventTimeController.text.trim();
    EventHandler.contactNumber = eventNumberController.text.trim();
    EventHandler.contactEmail = eventEmailController.text.trim();
    EventHandler.causeArea = _industry_value;

    Get.to(
      () => AddLocation(),
      duration: Duration(seconds: 1),
      transition: Transition.rightToLeft,
    );

    // final education = Education(
    //   id: UserHandler.id,
    //   institute: institute,
    //   degree: degree,
    //   study_field: study_field,
    //   startDate: startDate,
    //   endDate: endDate,
    //   desc: desc,
    // );
    // controller.saveEducation(education);
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
        startDateController.text = _pickDate.toString().split(" ")[0];
      } else {
        _endDate = _pickDate;
        endDateController.text = _pickDate.toString().split(" ")[0];
      }
      setState(() {});
    }
  }

  List availableTimes = ["09:00 AM", "10:00 AM", "11:00 AM"];
  int _selectedIndex = -1;
  late String chooseTime = "";

  void selectTimePopup() {
    showDialog(
      // barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Select Start Time",
            style: const TextStyle(color: Colors.black),
          ),
          content: SizedBox(
            height: 200,
            width: double.maxFinite,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Icon(Icons.arrow_forward_ios_outlined),
                    SizedBox(
                      height: 180,
                      width: 215,
                      child: ListWheelScrollView.useDelegate(
                        onSelectedItemChanged: (time) {
                          print(availableTimes[time]);
                          _selectedIndex = time;
                        },
                        physics: const FixedExtentScrollPhysics(),
                        itemExtent: 80,
                        perspective: 0.005,
                        diameterRatio: 5,
                        childDelegate: ListWheelChildBuilderDelegate(
                          childCount: availableTimes.length,
                          builder: (context, index) {
                            return Container(
                              height: 50,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: KColors.primary,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  availableTimes[index],
                                  style: const TextStyle(
                                      fontSize: 30, color: KColors.primary),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const Icon(Icons.arrow_back_ios_outlined),
                  ],
                )
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                  foregroundColor: KColors.primary.withOpacity(0.5)),
              child: const Text(
                "Back",
                style: TextStyle(color: KColors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog

                chooseTime = availableTimes[_selectedIndex];

                setState(() {
                  eventTimeController.text = availableTimes[_selectedIndex];
                });
                isValid();
                // onConfirm(); // Call the callback function to handle dismissal
              },
              style: TextButton.styleFrom(foregroundColor: KColors.primary),
              child: Text(
                "Confirm",
                style: TextStyle(color: KColors.primary),
              ),
            ),
          ],
        );
      },
    );
  }

  bool isValid() {
    if (chooseTime != "") {
      setState(() {});
      return true;
    } else {
      setState(() {});
      return false;
    }
  }
  // if (!_endDate.isAfter(_startDate)) {
  // PopupWarning.Warning(
  // title: "Dates are Invalid",
  // message: "Your study start Date, endDate is invalid.",
  // type: 2,
  // );
  // return;
  // }
}
