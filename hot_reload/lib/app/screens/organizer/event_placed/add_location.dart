import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hot_reload/app/screens/organizer/event_placed/create_event_2.dart';
import 'package:hot_reload/utils/helper/event_handler.dart';
import 'package:location/location.dart';

import '../../../../components/style/app_input_style.dart';
import '../../../../components/style/text_styles.dart';
import '../../../../components/widget/comman_widget/alert_popup.dart';
import '../../../../components/widget/comman_widget/show_confirm.dart';
import '../../../../services/location/location_service.dart';
import '../../../../utils/constraints/colors.dart';
import '../../../../utils/helper/device.dart';
import '../../../../utils/helper/map_helper.dart';
import '../../../../utils/helper/user_location.dart';

class AddLocation extends StatefulWidget {
  const AddLocation({Key? key}) : super(key: key);

  @override
  State<AddLocation> createState() => Add_LocationState();
}

class Add_LocationState extends State<AddLocation> {
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
        actions: [
          IconButton(
            splashRadius: 20,
            alignment: Alignment.center,
            onPressed: () {
              ShowConfirm.dialog(context, "Don't you want to continue ?", () {
                // Get.offAll(
                //   duration: Duration(milliseconds: 1000),
                //   transition: Transition.rightToLeft,
                //   EmpHomeScreen(),
                // );
                setState(() {});
              });
            },
            icon: Icon(
              Icons.home_rounded,
              color: Colors.black,
              size: 30,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 17.0,
          right: 17.0,
        ),
        child: Container(
          width: width,
          height: height,
          child: Column(
            children: [
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
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),

              SizedBox(
                height: 10,
              ),
              // Image.asset(
              //   tlocationImage,
              //   width: width,
              //   height: height / 4,
              // ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xffb9b9b9),
                      blurRadius: 10,
                      offset: Offset(0, 2),
                      // blurStyle: BlurStyle.solid,
                    ),
                  ],
                ),
                child: TextField(
                  cursorColor: Colors.black,
                  cursorHeight: 20,
                  controller: locationController,
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
                      hintText: "Sri Lanka",
                      labelText: "Select a Location",
                      hintStyle: KTextStyles.smallerGText,
                      labelStyle: KTextStyles.smallerBText,
                      floatingLabelStyle: KTextStyles.blackXlText,
                      alignLabelWithHint: true,
                      prefixIcon: Icon(
                        Icons.location_pin,
                        color: KColors.primary,
                      )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  width: width,
                  // height: height / 2.6,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: UserLocation.currentP == _srilanka
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: KColors.primary,
                          ),
                        )
                      : Stack(
                          children: [
                            GoogleMap(
                              mapType: MapType.normal,
                              initialCameraPosition: _srilankaCamera,
                              myLocationEnabled: true,
                              zoomGesturesEnabled: true,
                              zoomControlsEnabled: true,
                              myLocationButtonEnabled: false,
                              onMapCreated: (GoogleMapController controller) {
                                _controller.complete(controller);
                                newMapController = controller;
                              },
                              onTap: _addMarker,
                              // Function called when the map is tapped
                              markers: locationService.getOneMarker(),
                            ),
                            // set the camera position to the user's live location
                            Positioned(
                              top: 10,
                              right: 10,
                              child: FloatingActionButton(
                                backgroundColor: Colors.black,
                                onPressed: () {
                                  mapHelper.cameraToPosition(
                                      UserLocation.currentP!, _controller);
                                },
                                child: const Icon(
                                  Icons.my_location,
                                  size: 24,
                                  color: KColors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              MaterialButton(
                animationDuration: const Duration(milliseconds: 10000),
                height: 60,
                minWidth: double.infinity,
                disabledColor: Colors.black45,
                onPressed: locationController.text.toString().isNotEmpty
                    ? () {
                        // print(istapedPoint);
                        if (istapedPoint) {
                          EventHandler.latitude = selectLocation.latitude;
                          EventHandler.longitude = selectLocation.longitude;
                          EventHandler.location =
                              locationController.text.trim().toString();

                          Get.to(
                            () => CreateEvent2(),
                            transition: Transition.rightToLeftWithFade,
                            duration: Duration(
                              milliseconds: 1200,
                            ),
                          );
                        } else {
                          AlertPopup.warning(
                            title: "Location Not Selected",
                            message:
                                "Please select the location after you can change the location name.",
                            type: 2,
                          );
                        }
                      }
                    : null,
                color: Colors.black87,
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: locationController.text.toString().isNotEmpty
                          ? Colors.black
                          : Colors.black45,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: locationController.text.toString().isNotEmpty
                    ? Text(
                        "Next",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      )
                    : Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 25,
                                width: 25,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                )),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              "Add Your Location",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // google map controller
  final Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController newMapController;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // location controller for find to current location
  final Location _locationController = Location();

  // static LatLng? currentP;

  // initial position
  static const LatLng _srilanka = LatLng(7.927363, 80.687698);

  // initial camera position
  final CameraPosition _srilankaCamera = UserLocation.currentP == _srilanka
      ? const CameraPosition(
          target: _srilanka,
          zoom: 15,
        )
      : CameraPosition(
          target: UserLocation.currentP,
          zoom: 15,
        );

  late TextEditingController locationController = TextEditingController();

  LocationService locationService = LocationService();
  MapHelper mapHelper = MapHelper();

  int selectedIndex = -1;
  bool istapedPoint = false;

  // brake camera auto focus part
  bool initialValu = true;

  // get the current position value using user location class
  LatLng? _currentP = UserLocation.currentP;

  late LatLng selectLocation;

  @override
  void initState() {
    // call camera position function for when page open time only
    if (initialValu && _currentP != null) {
      setState(() {
        if (_currentP == _srilanka) {
          initialValu = true;
        } else {
          initialValu = false;
          // mapHelper.cameraToPosition(UserLocation.currentP, _controller);
          // mapHelper.getPolylinePoints(UserLocation.currentP, destination);
        }
      });
    }

    // call the get location method
    getLocation();
    _clearMarkers();

    super.initState();
  }

  @override
  void dispose() {
    newMapController.dispose();
    locationController.dispose();
    // _timer.cancel();
    super.dispose();
  }

  // get current location
  Future<void> getLocation() async {
    try {
      _locationController.onLocationChanged
          .listen((LocationData currentLocation) {
        if (currentLocation.latitude != null &&
            currentLocation.longitude != null) {
          if (mounted) {
            setState(() {
              UserLocation.currentP =
                  LatLng(currentLocation.latitude!, currentLocation.longitude!);

              if (kDebugMode) {
                // print(UserLocation.currentP);
              }

              if (initialValu) {
                initialValu = false;
                // _cameraToPosition(_currentP!);
                mapHelper.cameraToPosition(UserLocation.currentP!, _controller);
              }
            });
          }
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print("Google Map Error;\n\n $e\n\n");
      }
    }
  }

// user taped markers added to the Set
  void _addMarker(LatLng tappedPoint) async {
    dynamic markers;

    // user select location
    final address = await locationService.getAddressFromLatLng(tappedPoint);
    locationController.text = address;
    selectLocation = tappedPoint;

    setState(() {
      istapedPoint = true;
      locationService.addOneMarker(tappedPoint, "Choose Location");
      markers = locationService.getOneMarker();
    });
  }

// clear taped point when clicked the outside of google map
  void _clearMarkers() {
    setState(() {
      locationService
          .clearTappedPoints(); // Clear tapped points in LocationService
    });
  }
}
