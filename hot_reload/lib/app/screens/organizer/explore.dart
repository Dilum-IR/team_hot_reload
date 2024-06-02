import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../utils/constraints/colors.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  State<Explore> createState() => _ExploreState();
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

class _ExploreState extends State<Explore> {
  String selectedCauseArea = 'Children';
  String selectedTimeCommitment = '6-12 months';
  List<String> skills = [
    'Communication',
    'Time Management',
    'Adaptability',
    'Problem Solving',
    'Teamwork',
    'Compassion',
    'Friendliness',
    'Enthusiasm'
  ];
  List<String> selectedSkills = ['Communication', 'Problem Solving'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text('Explore', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text('Cause Area',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCauseAreaOption(
                      'Children', 'assets/images/page_images/children.jpg'),
                  SizedBox(
                    width: 20,
                  ),
                  _buildCauseAreaOption(
                      'Education', 'assets/images/page_images/education.jpg'),
                  SizedBox(
                    width: 20,
                  ),
                  _buildCauseAreaOption(
                      'Health', 'assets/images/page_images/health.jpg'),
                  SizedBox(
                    width: 20,
                  ),
                  _buildCauseAreaOption(
                      'Disability', 'assets/images/page_images/disability.jpg'),
                  SizedBox(
                    width: 20,
                  ),
                  _buildCauseAreaOption('Environment',
                      'assets/images/page_images/enviroment.jpg'),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text('Location',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_on),
                hintText: 'Colombo, Sri Lanka',
              ),
            ),
            SizedBox(height: 16),
            Text('Time Commitment',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ['6-12 months', 'Less than 3 months', '3-6 months']
                    .map((causeArea) => Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ChoiceChip(
                            label: Text(causeArea),
                            selected: selectedCauseArea == causeArea,
                            onSelected: (selected) {
                              setState(() {
                                selectedCauseArea = causeArea;
                              });
                            },
                          ),
                        ))
                    .toList(),
              ),
            ),
            SizedBox(height: 16),
            Text('Skills',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              children: skills
                  .map((skill) => FilterChip(
                        label: Text(skill),
                        selected: selectedSkills.contains(skill),
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              selectedSkills.add(skill);
                            } else {
                              selectedSkills.remove(skill);
                            }
                          });
                        },
                      ))
                  .toList(),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {},
              child: Text('Find',
                  style: TextStyle(color: KColors.white, fontSize: 16)),
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCauseAreaOption(String causeArea, String imagePath) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCauseArea = causeArea;
        });
      },
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(imagePath),
            radius: 30,
            backgroundColor: selectedCauseArea == causeArea
                ? Colors.black
                : Colors.grey[200],
          ),
          SizedBox(height: 4),
          Text(
            causeArea,
            style: TextStyle(
              color:
                  selectedCauseArea == causeArea ? Colors.black : Colors.grey,
              fontWeight: selectedCauseArea == causeArea
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
