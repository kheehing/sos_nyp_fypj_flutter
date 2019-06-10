import 'updateprofile_model.dart';

class Repository {
  List<Map> getAll() => _schoolCourse;

  getLocalBySchool(String school) => _schoolCourse
      .map((map) => Model.fromJson(map))
      .where((item) => item.school == school)
      .map((item) => item.course)
      .expand((i) => i)
      .toList();

  List<String> getSchool() => _schoolCourse
      .map((map) => Model.fromJson(map))
      .map((item) => item.school)
      .toList();

  List _schoolCourse = [
    {
      "school": "SIT",
      "course": [
        "Common ICT Programme",
        "Business & Financial Technology",
        "Business Intelligence & Analytics",
        "Cybersecurity & Digital Forensics",
        "Infocomm & Security",
        "Information Technology",
        "Business Informatics*",
        "Financial Informatics*",
      ]
    },
    {
      "school": "SBM",
      "course": [
        "Accountancy & Finance",
        "Banking & Finance",
        "Business Management",
        "Common Business Programme",
        "Food & Beverage Business",
        "Hospitality & Tourism Management",
        "Mass Media Management",
        "Sport & Wellness Management",
      ]
    },
    {
      "school": "SCL",
      "course": [
        "Biologics & Process Technology",
        "Chemical & Pharmaceutical Technology",
        "Food Science & Nutrition",
        "Medicinal Chemistry",
        "Molecular Biotechnology",
        "Pharmaceutical Science",
        "Chemical & Green Technology*",
      ]
    },
    {
      "school": "SDN",
      "course": [
        "Industrial Design",
        "Spatial Design",
        "Architecture",
        "Visual Communication",
      ]
    },
    {
      "school": "SEG",
      "course": [
        "Common Engineering Programme",
        "Aeronautical & Aerospace Technology",
        "Aerospace Systems & Management",
        "Biomedical Engineering",
        "Advanced & Digital Manufacturing",
        "Electronic & Computer Engineering",
        "Electrical Engineering with Eco-Design",
        "Engineering with Business",
        "Infocomm & Media Engineering",
        "Nanotechnology & Materials Science",
        "Robotics & Mechatronics",
        "Aerospace/Electrical/Electronics Programme*",
        "Aerospace/Mechatronics Programme*",
        "Digital & Precision Engineering*",
        "Electronic Systems*",
        "Multimedia & Infocomm Technology*",
      ]
    },
    {
      "school": "SHS",
      "course": [
        "Oral Health Therapy",
        "Nursing",
        "Social Sciences",
      ]
    },
    {
      "school": "SIDM",
      "course": [
        "Animation & Visual Effects",
        "Digital Game Art & Design",
        "Game Development & Technology",
        "Interaction Design",
        "Motion Graphics Design",
      ]
    },
  ];
}
