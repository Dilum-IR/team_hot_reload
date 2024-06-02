import 'dart:convert';
import 'package:readmore/readmore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class manageapplication1 extends StatefulWidget {
  const manageapplication1({Key? key}) : super(key: key);

  @override
  State<manageapplication1> createState() => _manageapplication1State();
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

class _manageapplication1State extends State<manageapplication1> {
  //final controller = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Applications'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search Applications',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Received',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  value: 'Carbon Neutral Program',
                  items: <String>['Carbon Neutral Program'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    // Handle dropdown changes
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    child: Icon(Icons.person, color: Colors.grey),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Gary Monroe sent an application for Mexican Stoves Project.',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Spacer(),
                          Text(
                            '6 hours ago',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // title: Text(
                  //   'Gary Monroe sent an application for Mexican Stoves Project.',
                  //   style: TextStyle(fontWeight: FontWeight.bold),
                  // ),
                  // subtitle: Text('6 hours ago'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
//
