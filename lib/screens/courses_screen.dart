// import 'package:flutter/material.dart';
// import '../models/course_model.dart'; // assume correct path
// // import your Firebase or service logic here

// class CourseMaterialScreen extends StatefulWidget {
//   const CourseMaterialScreen({super.key});

//   @override
//   State<CourseMaterialScreen> createState() => _CourseMaterialScreenState();
// }

// class _CourseMaterialScreenState extends State<CourseMaterialScreen> {
//   String _search = "";
//   List<CourseMaterial> _allCourses = []; // Fill from DB
//   List<CourseMaterial> _filteredCourses = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadCourses();
//   }

//   void _loadCourses() async {
//     // TODO: Replace with DB fetch
//     _allCourses = [
//       CourseMaterial(
//         id: "1",
//         title: "Introduction to Programming",
//         description: "Covers basics of variables, loops, and conditions.",
//         pdfUrls: ["https://example.com/intro1.pdf", "https://example.com/intro2.pdf"],
//       ),
//       CourseMaterial(
//         id: "2",
//         title: "Data Structures",
//         description: "Includes arrays, stacks, queues, and trees.",
//         pdfUrls: ["https://example.com/ds.pdf"],
//       ),
//       CourseMaterial(
//         id: "3",
//         title: "Artificial Intellegence",
//         description: "Includes arrays, stacks, queues, and trees.",
//         pdfUrls: ["https://example.com/ds.pdf"],
//       ),
//     ];

//     _filterCourses();
//   }

//   void _filterCourses() {
//     setState(() {
//       _filteredCourses = _allCourses
//           .where((c) => c.title.toLowerCase().contains(_search.toLowerCase()))
//           .toList();
//     });
//   }

//   void _showCourseDetails(CourseMaterial course) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (_) => Padding(
//         padding: const EdgeInsets.all(16),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(course.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 8),
//               Text(course.description),
//               const SizedBox(height: 16),
//               const Text("Materials:", style: TextStyle(fontWeight: FontWeight.bold)),
//               ...course.pdfUrls.map((url) => ListTile(
//                     leading: const Icon(Icons.picture_as_pdf),
//                     title: Text(url.split('/').last),
//                     onTap: () {
//                       // Open in browser or viewer
//                     },
//                   )),
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Course Materials")),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               decoration: const InputDecoration(
//                 prefixIcon: Icon(Icons.search),
//                 hintText: "Search courses...",
//                 border: OutlineInputBorder(),
//               ),
//               onChanged: (value) {
//                 _search = value;
//                 _filterCourses();
//               },
//             ),
//           ),
//           Expanded(
//             child: _filteredCourses.isEmpty
//                 ? const Center(child: Text("No courses found"))
//                 : ListView.builder(
//                     itemCount: _filteredCourses.length,
//                     itemBuilder: (context, index) {
//                       final course = _filteredCourses[index];
//                       return Card(
//                         child: ListTile(
//                           title: Text(course.title),
//                           subtitle: Text(course.description, maxLines: 1, overflow: TextOverflow.ellipsis),
//                           onTap: () => _showCourseDetails(course),
//                         ),
//                       );
//                     },
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/course_model.dart';

class CourseMaterialScreen extends StatefulWidget {
  const CourseMaterialScreen({super.key});

  @override
  State<CourseMaterialScreen> createState() => _CourseMaterialScreenState();
}

class _CourseMaterialScreenState extends State<CourseMaterialScreen> {
  String _search = "";
  List<CourseMaterial> _allCourses = [];
  List<CourseMaterial> _filteredCourses = [];

  @override
  void initState() {
    super.initState();
    _loadCourses();
  }

  void _loadCourses() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('courses').get();
      final courses = snapshot.docs.map((doc) => CourseMaterial.fromFirestore(doc)).toList();
      setState(() {
        _allCourses = courses;
        _filterCourses();
      });
    } catch (e) {
      print("Error fetching courses: $e");
    }
  }

  void _filterCourses() {
    setState(() {
      _filteredCourses = _allCourses
          .where((c) => c.title.toLowerCase().contains(_search.toLowerCase()))
          .toList();
    });
  }

  void _showCourseDetails(CourseMaterial course) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(course.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(course.description),
              const SizedBox(height: 16),
              const Text("Materials:", style: TextStyle(fontWeight: FontWeight.bold)),
              ...course.pdfUrls.map((url) => ListTile(
                    leading: const Icon(Icons.picture_as_pdf),
                    title: Text(url.split('/').last),
                    onTap: () {
                      // You can use url_launcher to open the link
                    },
                  )),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Course Materials")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search courses...",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                _search = value;
                _filterCourses();
              },
            ),
          ),
          Expanded(
            child: _filteredCourses.isEmpty
                ? const Center(child: Text("No courses found"))
                : ListView.builder(
                    itemCount: _filteredCourses.length,
                    itemBuilder: (context, index) {
                      final course = _filteredCourses[index];
                      return Card(
                        child: ListTile(
                          title: Text(course.title),
                          subtitle: Text(course.description, maxLines: 1, overflow: TextOverflow.ellipsis),
                          onTap: () => _showCourseDetails(course),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
