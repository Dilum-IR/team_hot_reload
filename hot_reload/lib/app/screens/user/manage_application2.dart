import 'dart:convert';
import 'package:readmore/readmore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class manageapplication2 extends StatefulWidget {
  const manageapplication2({Key? key}) : super(key: key);

  @override
  State<manageapplication2> createState() => _manageApplication2State();
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

class _manageApplication2State extends State<manageapplication2> {
  //final controller = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Applications'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            // Handle menu button press
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search Applications',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 60.0),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 18.0,
              mainAxisSpacing: 18.0,
              children: [
                _buildStatusCard('Received', '146'),
                _buildStatusCard('Approved', '9'),
                _buildStatusCard('Rejected', '2'),
                _buildStatusCard('Pending', '11'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(String title, String count) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20.0),
          ),
          Text(
            count,
            style: TextStyle(fontSize: 44.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
//
