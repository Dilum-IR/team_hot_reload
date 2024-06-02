import 'dart:convert';
import 'package:readmore/readmore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
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

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            // Handle menu button press
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                suffixIcon: Icon(Icons.filter_list),
                hintText: 'Search Events',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 16.0,
              children: [
                _buildStatusCard('Projects Completed', '1.3 K'),
                _buildStatusCard('Active Volunteers', '754'),
                _buildStatusCard('Donations Received', '\$6M+'),
              ],
            ),
            SizedBox(height: 6.0),
            Text('Next Event',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            _buildEventCard('Wildlife Habitat Enhancement',
                'Everglades National Park, Florida', '1 day'),
            SizedBox(height: 16.0),
            Text('Organizations',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                spacing: 12.0,
                runSpacing: 16.0,
                children: [
                  _buildOrganizationCircle('Planet Protectors'),
                  _buildOrganizationCircle('Clean Air Initiative'),
                  _buildOrganizationCircle('Unity in Action'),
                  _buildOrganizationCircle('Active Lives'),
                  _buildOrganizationCircle('Hope Crew'),
                  _buildOrganizationCircle('View All'),
                ],
              ),
            ),
            SizedBox(height: 26.0),
            Text('Current Programs',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            _buildEventCard('Current Program Example', '', '12 days'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle FAB press
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildStatusCard(String title, String count) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            count,
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(String title, String location, String daysLeft) {
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
                  mainAxisAlignment: MainAxisAlignment
                      .start, // Change to MainAxisAlignment.start
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      daysLeft.split(' ')[0], // Get the number part
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      daysLeft.split(' ')[1], // Get the 'day' part
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrganizationCircle(String name) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30.0,
          backgroundColor: Colors.grey[200],
          child: Icon(Icons.group, size: 30.0),
        ),
        SizedBox(height: 8.0),
        Container(
          width: 60.0, // Adjust the width to control wrapping
          child: Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.0),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
