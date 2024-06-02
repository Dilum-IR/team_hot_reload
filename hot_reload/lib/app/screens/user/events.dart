import 'dart:convert';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../controllers/user/user_feature_controller.dart';
import '../../controllers/user/user_signup_controller.dart';
import '../../model/event_model.dart';

class events extends StatefulWidget {
  const events({Key? key}) : super(key: key);

  @override
  State<events> createState() => _eventsState();
}

class RowBuilder extends StatelessWidget {
  final IconData icon;
  final String text;

  const RowBuilder({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start, // Align text to the top
      children: [
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Icon(icon, size: 8),
        ),
        Expanded(
          child: Text(
            text,
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}

class _eventsState extends State<events> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('Environment'),
                  SizedBox(width: 8.0),
                  _buildFilterChip('Health'),
                  SizedBox(width: 8.0),
                  _buildFilterChip('6-12 months'),
                  SizedBox(width: 8.0),
                  _buildFilterChip('More...'),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            _buildEventCard('Clean the Coast', 'Santa Monica Beach, California',
                '3 days', 'Environment'),
            SizedBox(height: 8.0),
            _buildEventCard('Wildlife Habitat Enhancement',
                'Everglades National Park, Florida', '3 days', 'Environment'),
            SizedBox(height: 8.0),
            _buildEventCard(
                'Sustainable City Initiative',
                'Pike Place Market, Seattle, Washington',
                '3 days',
                'Environment'),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    return Chip(
      label: Text(label),
      backgroundColor: Colors.black,
      labelStyle: TextStyle(color: Colors.white),
    );
  }

  Widget _buildEventCard(
      String title, String location, String daysLeft, String tag) {
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
                Image.asset(
                  'img/ribbon.png',
                  width: 60,
                  height: 80,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      daysLeft.split(' ')[0], // Get the number part
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      daysLeft.split(' ')[1], // Get the 'days' part
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 8.0,
            right: 8.0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                tag,
                style: TextStyle(color: Colors.white, fontSize: 12.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
