import 'dart:convert';
import 'package:readmore/readmore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class addreview extends StatefulWidget {
  const addreview({Key? key}) : super(key: key);

  @override
  State<addreview> createState() => _addreviewState();
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

class _addreviewState extends State<addreview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Review'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.upload, color: Colors.grey),
                      SizedBox(height: 8),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Upload\n',
                              style: TextStyle(color: Colors.grey),
                            ),
                            TextSpan(
                              text: 'photos',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Nature Nurturers Rally',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'May 27, 2024',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            const Center(
              child: Text(
                'How would you rate this event?',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return Icon(Icons.star_border);
              }),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Organization'),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(Icons.star_border);
                  }),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Communication'),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(Icons.star_border);
                  }),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Support'),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(Icons.star_outline);
                  }),
                ),
              ],
            ),
            SizedBox(height: 24),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Review Title',
              ),
            ),
            SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Review',
              ),
              maxLines: 4,
            ),
            SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle submit button press
                },
                child: Text('Submit'),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFEFEFEF),
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  textStyle: TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
