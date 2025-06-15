// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:unimate/screens/assignments_screen.dart';
// import '../widgets/custom_feature_button.dart';
// import '../screens/schedule_screen.dart'; // <- Import your ScheduleScreen
// import '../screens/assignments_screen.dart';
// import '../screens/lost_found_screen.dart';
// import '../screens/digital_id_screen.dart';
// import '../screens/courses_screen.dart';
// import '../screens/attendance_screen.dart';
// import '../screens/notifications_screen.dart';

// class HomeScreen extends StatelessWidget {
//   final User? user = FirebaseAuth.instance.currentUser;

//   void _navigateToFeature(BuildContext context, String feature) {
//     Navigator.of(context).push(_createRoute(feature));
//   }

//   Route _createRoute(String feature) {
//     Widget page;

//     // Route based on feature name
//     switch (feature) {
//       case 'Schedule':
//         page = ScheduleScreen(); // Show the actual schedule screen
//         break;
//       case 'Assignments':
//         page = AssignmentScreen(); // Show the actual schedule screen
//         break;
//       case 'Lost & Found':
//         page = LostFoundScreen(); // Show the actual schedule screen
//         break;
//       case 'Digital ID':
//         page = DigitalIdScreen(); // Show the actual schedule screen
//         break;
//       case 'Course Materials':
//         page = CourseMaterialScreen(); // Show the actual schedule screen
//         break;
//       case 'Attendance':
//         page = AttendanceScreen(); // Show the actual schedule screen
//         break;
//       case 'Notifications':
//         page = NotificationScreen(); // Show the actual schedule screen
//         break;
//       default:
//         page = FeatureScreen(
//           featureName: feature,
//         ); // Fallback to generic screen
//     }

//     return PageRouteBuilder(
//       pageBuilder: (context, animation, secondaryAnimation) => page,
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         // Custom transition: expand and fade in
//         final fade = Tween<double>(begin: 0.0, end: 1.0).animate(animation);
//         final scale = Tween<double>(begin: 0.95, end: 1.0).animate(animation);

//         return FadeTransition(
//           opacity: fade,
//           child: ScaleTransition(scale: scale, child: child),
//         );
//       },
//       transitionDuration: const Duration(milliseconds: 400),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     String initials = '';
//     if (user?.email != null && user!.email!.isNotEmpty) {
//       initials = user!.email!.substring(0, 2).toUpperCase();
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('UniMate - Smart Campus Companion'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout),
//             onPressed: () async {
//               await FirebaseAuth.instance.signOut();
//               Navigator.pushReplacementNamed(context, '/');
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 CircleAvatar(
//                   radius: 30,
//                   child: Text(
//                     initials,
//                     style: const TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: Text(
//                     'Welcome, ${user?.email ?? 'User'}',
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 30),

//             GridView.count(
//               crossAxisCount: 2,
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               mainAxisSpacing: 20,
//               crossAxisSpacing: 20,
//               children: [
//                 CustomFeatureCardButton(
//                   title: 'Course Schedule',
//                   icon: Icons.schedule,
//                   color: Colors.brown,
//                   onTap: () => _navigateToFeature(context, 'Schedule'),
//                 ),
//                 CustomFeatureCardButton(
//                   title: 'Course Materials',
//                   icon: Icons.book,
//                   color: Colors.deepPurple,
//                   onTap: () => _navigateToFeature(context, 'Course Materials'),
//                 ),
//                 CustomFeatureCardButton(
//                   title: 'Attendance',
//                   icon: Icons.check_circle,
//                   color: Colors.teal,
//                   onTap: () => _navigateToFeature(context, 'Attendance'),
//                 ),
//                 CustomFeatureCardButton(
//                   title: 'Assignments',
//                   icon: Icons.assignment,
//                   color: Colors.orange,
//                   onTap: () => _navigateToFeature(context, 'Assignments'),
//                 ),
//                 CustomFeatureCardButton(
//                   title: 'Notifications',
//                   icon: Icons.notifications,
//                   color: Colors.redAccent,
//                   onTap: () => _navigateToFeature(context, 'Notifications'),
//                 ),
//                 CustomFeatureCardButton(
//                   title: 'Digital ID',
//                   icon: Icons.badge,
//                   color: Colors.blueAccent,
//                   onTap: () => _navigateToFeature(context, 'Digital ID'),
//                 ),
//                 CustomFeatureCardButton(
//                   title: 'Lost & Found',
//                   icon: Icons.search,
//                   color: Colors.green,
//                   onTap: () => _navigateToFeature(context, 'Lost & Found'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Fallback screen for general features
// class FeatureScreen extends StatelessWidget {
//   final String featureName;
//   const FeatureScreen({Key? key, required this.featureName}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(featureName)),
//       body: Center(child: Text('This is the $featureName screen')),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:unimate/screens/assignments_screen.dart';
// import '../widgets/custom_feature_button.dart';
// import '../screens/schedule_screen.dart';
// import '../screens/lost_found_screen.dart';
// import '../screens/digital_id_screen.dart';
// import '../screens/courses_screen.dart';
// import '../screens/attendance_screen.dart';
// import '../screens/notifications_screen.dart';

// class HomeScreen extends StatelessWidget {
//   final User? user = FirebaseAuth.instance.currentUser;

//   void _navigateToFeature(BuildContext context, String feature) {
//     Navigator.of(context).push(_createRoute(feature));
//   }

//   Route _createRoute(String feature) {
//     Widget page;

//     switch (feature) {
//       case 'Schedule':
//         page = ScheduleScreen();
//         break;
//       case 'Assignments':
//         page = AssignmentScreen();
//         break;
//       case 'Lost & Found':
//         page = LostFoundScreen();
//         break;
//       case 'Digital ID':
//         page = DigitalIdScreen();
//         break;
//       case 'Course Materials':
//         page = CourseMaterialScreen();
//         break;
//       case 'Attendance':
//         page = AttendanceScreen();
//         break;
//       case 'Notifications':
//         page = NotificationScreen();
//         break;
//       default:
//         page = FeatureScreen(featureName: feature);
//     }

//     return PageRouteBuilder(
//       pageBuilder: (context, animation, secondaryAnimation) => page,
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         final fade = Tween<double>(begin: 0.0, end: 1.0).animate(animation);
//         final scale = Tween<double>(begin: 0.95, end: 1.0).animate(animation);

//         return FadeTransition(
//           opacity: fade,
//           child: ScaleTransition(scale: scale, child: child),
//         );
//       },
//       transitionDuration: const Duration(milliseconds: 400),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     String initials = '';
//     if (user?.email != null && user!.email!.isNotEmpty) {
//       initials = user!.email!.substring(0, 2).toUpperCase();
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('UniMate'),
//         leading: Builder(
//           builder: (context) => GestureDetector(
//             onTap: () => Scaffold.of(context).openDrawer(),
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: CircleAvatar(
//                 backgroundColor: Colors.white,
//                 child: Text(
//                   initials,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//       drawer: Drawer(
//         child: Column(
//           children: [
//             UserAccountsDrawerHeader(
//               currentAccountPicture: CircleAvatar(
//                 child: Text(
//                   initials,
//                   style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               accountName: const Text(""),
//               accountEmail: Text(user?.email ?? 'user@example.com'),
//             ),
//             ListTile(
//               leading: const Icon(Icons.logout),
//               title: const Text("Logout"),
//               onTap: () async {
//                 await FirebaseAuth.instance.signOut();
//                 Navigator.pushReplacementNamed(context, '/');
//               },
//             ),
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             GridView.count(
//               crossAxisCount: 2,
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               mainAxisSpacing: 20,
//               crossAxisSpacing: 20,
//               children: [
//                 CustomFeatureCardButton(
//                   title: 'Course Schedule',
//                   icon: Icons.schedule,
//                   color: Colors.brown,
//                   onTap: () => _navigateToFeature(context, 'Schedule'),
//                 ),
//                 CustomFeatureCardButton(
//                   title: 'Course Materials',
//                   icon: Icons.book,
//                   color: Colors.deepPurple,
//                   onTap: () => _navigateToFeature(context, 'Course Materials'),
//                 ),
//                 CustomFeatureCardButton(
//                   title: 'Attendance',
//                   icon: Icons.check_circle,
//                   color: Colors.teal,
//                   onTap: () => _navigateToFeature(context, 'Attendance'),
//                 ),
//                 CustomFeatureCardButton(
//                   title: 'Assignments',
//                   icon: Icons.assignment,
//                   color: Colors.orange,
//                   onTap: () => _navigateToFeature(context, 'Assignments'),
//                 ),
//                 CustomFeatureCardButton(
//                   title: 'Notifications',
//                   icon: Icons.notifications,
//                   color: Colors.redAccent,
//                   onTap: () => _navigateToFeature(context, 'Notifications'),
//                 ),
//                 CustomFeatureCardButton(
//                   title: 'Digital ID',
//                   icon: Icons.badge,
//                   color: Colors.blueAccent,
//                   onTap: () => _navigateToFeature(context, 'Digital ID'),
//                 ),
//                 CustomFeatureCardButton(
//                   title: 'Lost & Found',
//                   icon: Icons.search,
//                   color: Colors.green,
//                   onTap: () => _navigateToFeature(context, 'Lost & Found'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class FeatureScreen extends StatelessWidget {
//   final String featureName;
//   const FeatureScreen({Key? key, required this.featureName}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(featureName)),
//       body: Center(child: Text('This is the $featureName screen')),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/custom_feature_button.dart';
import '../screens/schedule_screen.dart';
import '../screens/assignments_screen.dart';
import '../screens/lost_found_screen.dart';
import '../screens/digital_id_screen.dart';
import '../screens/courses_screen.dart';
import '../screens/attendance_screen.dart';
import '../screens/notifications_screen.dart';

class HomeScreen extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  void _navigateToFeature(BuildContext context, String feature) {
    Navigator.of(context).push(_createRoute(feature));
  }

  Route _createRoute(String feature) {
    Widget page;
    switch (feature) {
      case 'Schedule':
        page = ScheduleScreen();
        break;
      case 'Assignments':
        page = AssignmentScreen();
        break;
      case 'Lost & Found':
        page = LostFoundScreen();
        break;
      case 'Digital ID':
        page = DigitalIdScreen();
        break;
      case 'Course Materials':
        page = CourseMaterialScreen();
        break;
      case 'Attendance':
        page = AttendanceScreen();
        break;
      case 'Notifications':
        page = NotificationScreen();
        break;
      default:
        page = FeatureScreen(featureName: feature);
    }

    return PageRouteBuilder(
      pageBuilder: (_, animation, __) => page,
      transitionsBuilder: (_, animation, __, child) => FadeTransition(
        opacity: animation,
        child: ScaleTransition(scale: animation, child: child),
      ),
      transitionDuration: const Duration(milliseconds: 400),
    );
  }

  @override
  Widget build(BuildContext context) {
    String initials = '';
    if (user?.email != null && user!.email!.isNotEmpty) {
      initials = user!.email!.substring(0, 2).toUpperCase();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8), // soft gray background
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F2D3D), // dark blue-gray
        title: const Text(
          'UniMate',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: CircleAvatar(
                backgroundColor: Colors.blueGrey[100],
                child: Text(
                  initials,
                  style: const TextStyle(
                    color: Color(0xFF1F2D3D),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          )
        ],
      ),
      endDrawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 40,
                child: Text(
                  initials,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                user?.email ?? '',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const Divider(height: 40),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.redAccent),
                title: const Text('Logout'),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, '/');
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome to your Campus Companion",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color(0xFF2E3A59),
              ),
            ),
            const SizedBox(height: 30),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              children: [
                CustomFeatureCardButton(
                  title: 'Course Schedule',
                  icon: Icons.schedule,
                  color: Colors.indigo,
                  onTap: () => _navigateToFeature(context, 'Schedule'),
                ),
                CustomFeatureCardButton(
                  title: 'Course Materials',
                  icon: Icons.book,
                  color: Colors.blueGrey,
                  onTap: () => _navigateToFeature(context, 'Course Materials'),
                ),
                CustomFeatureCardButton(
                  title: 'Attendance',
                  icon: Icons.check_circle,
                  color: Colors.teal,
                  onTap: () => _navigateToFeature(context, 'Attendance'),
                ),
                CustomFeatureCardButton(
                  title: 'Assignments',
                  icon: Icons.assignment,
                  color: Colors.deepOrange,
                  onTap: () => _navigateToFeature(context, 'Assignments'),
                ),
                CustomFeatureCardButton(
                  title: 'Notifications',
                  icon: Icons.notifications,
                  color: Colors.deepPurple,
                  onTap: () => _navigateToFeature(context, 'Notifications'),
                ),
                CustomFeatureCardButton(
                  title: 'Digital ID',
                  icon: Icons.badge,
                  color: Colors.blueAccent,
                  onTap: () => _navigateToFeature(context, 'Digital ID'),
                ),
                CustomFeatureCardButton(
                  title: 'Lost & Found',
                  icon: Icons.search,
                  color: Colors.green,
                  onTap: () => _navigateToFeature(context, 'Lost & Found'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FeatureScreen extends StatelessWidget {
  final String featureName;
  const FeatureScreen({Key? key, required this.featureName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(featureName)),
      body: Center(child: Text('This is the $featureName screen')),
    );
  }
}




