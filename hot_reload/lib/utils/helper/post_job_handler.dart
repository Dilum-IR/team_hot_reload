import 'package:google_maps_flutter/google_maps_flutter.dart';

class PostJobHandler {
  static late String id;
  static late String industry;
  static late String category;
  static late String job_position;

  static late String chooseLocation;
  static late int max_salary;
  static late int min_salary;

  static late String job_type;
  static late String type_of_workspace;
  static late String job_desc;
  static late String require;
  static late String responsi;
  static late String about;
  static late int view;
  static late bool is_view;
  static late LatLng lat_lang;

  static Map<String, Map<String, List<String>>> industryCategories = {
    'Technology': {
      'Software': [
        'Software Engineer',
        'UI/UX Designer',
        'Quality Assurance Engineer',
        'Project manager',
      ],
      'Hardware': [
        'Hardware Engineer',
        'Embedded Systems Engineer',
        'Firmware Engineer'
      ],
      'Internet': [
        'Web Developer',
        'DevOps Engineer',
        'Cloud Architect',
      ],
      'Telecommunications': [
        'Network Engineer',
        'Telecom Technician',
        'Wireless Engineer'
      ]
    },
    'Finance': {
      'Banking': [
        'Bank Teller',
        'Loan Officer',
        'Financial Analyst',
      ],
      'Investment': [
        'Financial Advisor',
        'Portfolio Manager',
        'Investment Banker'
      ],
      'Insurance': [
        'Insurance Agent',
        'Actuary',
        'Claims Adjuster',
      ],
      'Fintech': [
        'Blockchain Developer',
        'Data Scientist',
        'Risk Analyst',
      ]
    },
    'Healthcare': {
      'Pharmaceuticals': [
        'Pharmacist',
        'Clinical Research Associate',
        'Regulatory Affairs Specialist'
      ],
      'Medical Devices': [
        'Biomedical Engineer',
        'Medical Device Sales',
        'Quality Engineer'
      ],
      'Health IT': [
        'Health Informatics Specialist',
        'Health IT Project Manager',
        'Clinical Systems Analyst'
      ]
    },
    'Automotive': {
      'Manufacturing': [
        'Production Supervisor',
        'Assembly Line Worker',
        'Quality Control Inspector'
      ],
      'Sales': [
        'Sales Representative',
        'Sales Manager',
        'Automotive Finance Manager'
      ],
      'Aftermarket Services': [
        'Auto Mechanic',
        'Service Advisor',
        'Parts Specialist'
      ]
    },
    'Education': {
      'K-12': [
        'Teacher',
        'Principal',
        'School Counselor',
      ],
      'Higher Education': [
        'Professor',
        'Academic Advisor',
        'Registrar',
      ],
      'EdTech': [
        'Educational Technologist',
        'Instructional Designer',
        'EdTech Sales Representative'
      ]
    },
    'Hospitality': {
      'Hotels': [
        'Hotel Manager',
        'Front Desk Clerk',
        'Housekeeper',
      ],
      'Restaurants': [
        'Chef',
        'Waiter/Waitress',
        'Restaurant Manager',
      ],
      'Travel Agencies': [
        'Travel Agent',
        'Tour Guide',
        'Travel Consultant',
      ]
    },
    'Entertainment': {
      'Film': [
        'Actor/Actress',
        'Film Director',
        'Screenwriter',
      ],
      'Music': [
        'Musician',
        'Music Producer',
        'Music Teacher',
      ],
      'Gaming': [
        'Game Designer',
        'Game Programmer',
        'QA Tester',
      ],
      'Live Events': [
        'Event Planner',
        'Stage Manager',
        'Sound Technician',
      ]
    },
    // 'Retail': {
    //   'Online Retail': [
    //     'E-commerce Manager',
    //     'Digital Marketer',
    //     'Customer Service '
    //   ],
    //   'Brick-and-Mortar': [
    //     'Store Manager',
    //     'Retail Sales Associate',
    //     'Visual Merchandiser'
    //   ],
    //   'E-commerce': [
    //     'Fulfillment Specialist',
    //     'Inventory Manager',
    //     'Warehouse Associate'
    //   ]
    // },
  };

  static List<String> getIndustry() {
    List<String> industryList = [];

    industryCategories.forEach((industry, categories) {
      industryList.add(industry);
    });
    return industryList;
  }

  static List<String> getCategory(_industry) {
    List<String> categoryList = [];

    industryCategories[_industry]?.forEach((category, jobTypes) {
      categoryList.add(category);
    });
    return categoryList;
  }

  static List<String> getJobType(_industry, _category) {
    return industryCategories[_industry]![_category]!;
  }
}
