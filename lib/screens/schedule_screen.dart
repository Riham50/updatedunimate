// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_sticky_header/flutter_sticky_header.dart';
// import '../models/schedule_model.dart';
// import '../services/schedule_service.dart';
// import '../widgets/schedule_card.dart';

// class ScheduleScreen extends StatelessWidget {
//   final ScheduleService _service = ScheduleService();
//   final List<String> days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];

//   ScheduleScreen({super.key});

//   int _dayToIndex(String day) => days.indexOf(day);
//   bool _isToday(String day) => DateFormat('EEEE').format(DateTime.now()) == day;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('My Schedule')),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // You can implement schedule add dialog/screen
//         },
//         child: const Icon(Icons.add),
//       ),
//       body: StreamBuilder<List<ScheduleItem>>(
//         stream: _service.getScheduleStream(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

//           List<ScheduleItem> items = snapshot.data!;
//           items.sort((a, b) => _dayToIndex(a.day).compareTo(_dayToIndex(b.day)));

//           return CustomScrollView(
//             slivers: days.map((day) {
//               final dayItems = items.where((e) => e.day == day).toList();

//               if (dayItems.isEmpty) return const SliverToBoxAdapter(child: SizedBox());

//               return SliverStickyHeader(
//                 header: Container(
//                   height: 50.0,
//                   color: Colors.blueGrey[50],
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     day,
//                     style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 sliver: SliverList(
//                   delegate: SliverChildBuilderDelegate(
//                     (context, index) {
//                       final item = dayItems[index];
//                       return ScheduleCard(
//                         item: item,
//                         highlight: _isToday(day),
//                         onEdit: () {
//                           // Implement edit flow
//                         },
//                         onDelete: () async {
//                           await _service.deleteSchedule(item.id);
//                         },
//                       );
//                     },
//                     childCount: dayItems.length,
//                   ),
//                 ),
//               );
//             }).toList(),
//           );
//         },
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import '../models/schedule_model.dart';
// import '../services/schedule_service.dart';
// import '../widgets/schedule_card.dart';

// class ScheduleScreen extends StatelessWidget {
//   final ScheduleService _service = ScheduleService();
//   final List<String> days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];

//   ScheduleScreen({super.key});

//   int _dayToIndex(String day) => days.indexOf(day);
//   bool _isToday(String day) => DateFormat('EEEE').format(DateTime.now()) == day;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('My Schedule')),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // You can implement schedule add dialog/screen
//         },
//         child: const Icon(Icons.add),
//       ),
//       body: StreamBuilder<List<ScheduleItem>>(
//         stream: _service.getScheduleStream(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

//           List<ScheduleItem> items = snapshot.data!;
//           items.sort((a, b) => _dayToIndex(a.day).compareTo(_dayToIndex(b.day)));

//           return CustomScrollView(
//             slivers: days.map((day) {
//               final dayItems = items.where((e) => e.day == day).toList();
//               if (dayItems.isEmpty) return const SliverToBoxAdapter(child: SizedBox());

//               return SliverGroup(
//                 header: _DayHeader(day: day),
//                 items: dayItems,
//                 highlightToday: _isToday(day),
//                 onDelete: (id) async => await _service.deleteSchedule(id),
//               );
//             }).toList(),
//           );
//         },
//       ),
//     );
//   }
// }

// // Sticky Header Replacement
// class _DayHeader extends StatelessWidget {
//   final String day;

//   const _DayHeader({required this.day});

//   @override
//   Widget build(BuildContext context) {
//     return SliverPersistentHeader(
//       pinned: true,
//       delegate: _StickyHeaderDelegate(
//         minHeight: 50,
//         maxHeight: 50,
//         child: Container(
//           color: Colors.blueGrey[50],
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           alignment: Alignment.centerLeft,
//           child: Text(
//             day,
//             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
//   final double minHeight;
//   final double maxHeight;
//   final Widget child;

//   _StickyHeaderDelegate({required this.minHeight, required this.maxHeight, required this.child});

//   @override
//   double get minExtent => minHeight;

//   @override
//   double get maxExtent => maxHeight;

//   @override
//   Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return child;
//   }

//   @override
//   bool shouldRebuild(covariant _StickyHeaderDelegate oldDelegate) {
//     return child != oldDelegate.child || minHeight != oldDelegate.minHeight || maxHeight != oldDelegate.maxHeight;
//   }
// }

// // Combines header and item list
// class SliverGroup extends StatelessWidget {
//   final Widget header;
//   final List<ScheduleItem> items;
//   final bool highlightToday;
//   final Future<void> Function(String id) onDelete;

//   const SliverGroup({
//     required this.header,
//     required this.items,
//     required this.highlightToday,
//     required this.onDelete,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SliverList(
//       delegate: SliverChildListDelegate([
//         header,
//         ...items.map((item) => ScheduleCard(
//               item: item,
//               highlight: highlightToday,
//               onEdit: () {
//                 // Implement edit flow
//               },
//               onDelete: () => onDelete(item.id),
//             )),
//       ]),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_sticky_header/flutter_sticky_header.dart';
// import '../models/schedule_model.dart';
// import '../services/schedule_service.dart';
// import '../widgets/schedule_card.dart';

// class ScheduleScreen extends StatefulWidget {
//   const ScheduleScreen({super.key});

//   @override
//   State<ScheduleScreen> createState() => _ScheduleScreenState();
// }

// class _ScheduleScreenState extends State<ScheduleScreen> {
//   final ScheduleService _service = ScheduleService();
//   final List<String> days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
//   final List<String> periods = ['Morning 1', 'Morning 2', 'Afternoon 1', 'Afternoon 2'];

//   int _dayToIndex(String day) => days.indexOf(day);

//   bool _isToday(String day) => DateFormat('EEEE').format(DateTime.now()) == day;

//   void _showAddScheduleForm(BuildContext context) {
//     final _formKey = GlobalKey<FormState>();
//     String? selectedDay;
//     String? selectedPeriod;
//     String? courseName;
//     String? instructor;

//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (context) => Padding(
//         padding: EdgeInsets.only(
//           bottom: MediaQuery.of(context).viewInsets.bottom,
//           left: 16,
//           right: 16,
//           top: 16,
//         ),
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 DropdownButtonFormField<String>(
//                   decoration: const InputDecoration(labelText: "Day"),
//                   items: days.map((day) => DropdownMenuItem(value: day, child: Text(day))).toList(),
//                   onChanged: (val) => selectedDay = val,
//                   validator: (val) => val == null ? "Please select a day" : null,
//                 ),
//                 DropdownButtonFormField<String>(
//                   decoration: const InputDecoration(labelText: "Period"),
//                   items: periods.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
//                   onChanged: (val) => selectedPeriod = val,
//                   validator: (val) => val == null ? "Please select a period" : null,
//                 ),
//                 TextFormField(
//                   decoration: const InputDecoration(labelText: "Course Name"),
//                   onChanged: (val) => courseName = val,
//                   validator: (val) => val == null || val.isEmpty ? "Enter course name" : null,
//                 ),
//                 TextFormField(
//                   decoration: const InputDecoration(labelText: "Instructor"),
//                   onChanged: (val) => instructor = val,
//                   validator: (val) => val == null || val.isEmpty ? "Enter instructor name" : null,
//                 ),
//                 const SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: () async {
//                     if (_formKey.currentState!.validate()) {
//                       final newItem = ScheduleItem(
//                         id: DateTime.now().millisecondsSinceEpoch.toString(),
//                         day: selectedDay!,
//                         period: selectedPeriod!,
//                         courseName: courseName!,
//                         instructor: instructor!,
//                       );
//                       await _service.addSchedule(newItem);
//                       Navigator.of(context).pop();
//                     }
//                   },
//                   child: const Text("Add Schedule"),
//                 ),
//                 const SizedBox(height: 12),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('My Schedule')),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _showAddScheduleForm(context),
//         child: const Icon(Icons.add),
//       ),
//       body: StreamBuilder<List<ScheduleItem>>(
//         stream: _service.getScheduleStream(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

//           List<ScheduleItem> items = snapshot.data!;
//           items.sort((a, b) => _dayToIndex(a.day).compareTo(_dayToIndex(b.day)));

//           return CustomScrollView(
//             slivers: days.map((day) {
//               final dayItems = items.where((e) => e.day == day).toList();
//               dayItems.sort((a, b) => periods.indexOf(a.period).compareTo(periods.indexOf(b.period)));

//               if (dayItems.isEmpty) {
//                 return const SliverToBoxAdapter(child: SizedBox.shrink());
//               }

//               return SliverStickyHeader(
//                 header: Container(
//                   height: 50.0,
//                   color: Colors.blueGrey[50],
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     day,
//                     style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 sliver: SliverList(
//                   delegate: SliverChildBuilderDelegate(
//                     (context, index) {
//                       final item = dayItems[index];
//                       return ScheduleCard(
//                         item: item,
//                         highlight: _isToday(day),
//                         onEdit: () {
//                           // Optional: implement edit form
//                         },
//                         onDelete: () async {
//                           await _service.deleteSchedule(item.id);
//                         },
//                       );
//                     },
//                     childCount: dayItems.length,
//                   ),
//                 ),
//               );
//             }).toList(),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// Removed flutter_sticky_header import
import '../models/schedule_model.dart';
import '../services/schedule_service.dart';
import '../widgets/schedule_card.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

// Custom SliverPersistentHeaderDelegate for sticky headers
class _SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String day;
  _SliverHeaderDelegate(this.day);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: maxExtent,
      color: Colors.blueGrey[50],
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.centerLeft,
      child: Text(
        day,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant _SliverHeaderDelegate oldDelegate) {
    return oldDelegate.day != day;
  }
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final ScheduleService _service = ScheduleService();
  final List<String> days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
  final List<String> periods = ['Morning 1', 'Morning 2', 'Afternoon 1', 'Afternoon 2'];

  int _dayToIndex(String day) => days.indexOf(day);

  bool _isToday(String day) => DateFormat('EEEE').format(DateTime.now()) == day;

  void _showAddScheduleForm(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String? selectedDay;
    String? selectedPeriod;
    String? courseName;
    String? instructor;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: "Day"),
                  items: days.map((day) => DropdownMenuItem(value: day, child: Text(day))).toList(),
                  onChanged: (val) => selectedDay = val,
                  validator: (val) => val == null ? "Please select a day" : null,
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: "Period"),
                  items: periods.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
                  onChanged: (val) => selectedPeriod = val,
                  validator: (val) => val == null ? "Please select a period" : null,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Course Name"),
                  onChanged: (val) => courseName = val,
                  validator: (val) => val == null || val.isEmpty ? "Enter course name" : null,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Instructor"),
                  onChanged: (val) => instructor = val,
                  validator: (val) => val == null || val.isEmpty ? "Enter instructor name" : null,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final newItem = ScheduleItem(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        day: selectedDay!,
                        period: selectedPeriod!,
                        courseName: courseName!,
                        instructor: instructor!,
                      );
                      await _service.addSchedule(newItem);
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text("Add Schedule"),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }


void _showEditScheduleForm(BuildContext context, ScheduleItem item) {
  final _formKey = GlobalKey<FormState>();
  String? selectedDay = item.day;
  String? selectedPeriod = item.period;
  String? courseName = item.courseName;
  String? instructor = item.instructor;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: selectedDay,
                decoration: const InputDecoration(labelText: "Day"),
                items: days.map((day) => DropdownMenuItem(value: day, child: Text(day))).toList(),
                onChanged: (val) => selectedDay = val,
                validator: (val) => val == null ? "Please select a day" : null,
              ),
              DropdownButtonFormField<String>(
                value: selectedPeriod,
                decoration: const InputDecoration(labelText: "Period"),
                items: periods.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
                onChanged: (val) => selectedPeriod = val,
                validator: (val) => val == null ? "Please select a period" : null,
              ),
              TextFormField(
                initialValue: courseName,
                decoration: const InputDecoration(labelText: "Course Name"),
                onChanged: (val) => courseName = val,
                validator: (val) => val == null || val.isEmpty ? "Enter course name" : null,
              ),
              TextFormField(
                initialValue: instructor,
                decoration: const InputDecoration(labelText: "Instructor"),
                onChanged: (val) => instructor = val,
                validator: (val) => val == null || val.isEmpty ? "Enter instructor name" : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final updatedItem = ScheduleItem(
                      id: item.id, // keep the same id to update
                      day: selectedDay!,
                      period: selectedPeriod!,
                      courseName: courseName!,
                      instructor: instructor!,
                    );
                    await _service.updateSchedule(updatedItem);
                    Navigator.of(context).pop();
                  }
                },
                child: const Text("Update Schedule"),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Schedule')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddScheduleForm(context),
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<ScheduleItem>>(
        stream: _service.getScheduleStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          List<ScheduleItem> items = snapshot.data!;
          items.sort((a, b) => _dayToIndex(a.day).compareTo(_dayToIndex(b.day)));

          // We build a list of slivers, each day has a sticky header + sliver list
          List<Widget> slivers = [];
          for (var day in days) {
            final dayItems = items.where((e) => e.day == day).toList();
            dayItems.sort((a, b) => periods.indexOf(a.period).compareTo(periods.indexOf(b.period)));

            if (dayItems.isEmpty) continue;

            slivers.add(
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverHeaderDelegate(day),
              ),
            );
            slivers.add(
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final item = dayItems[index];
                    return ScheduleCard(
                      item: item,
                      highlight: _isToday(day),
                      onEdit: () => _showEditScheduleForm(context, item),
                      onDelete: () async {
                        await _service.deleteSchedule(item.id);
                      },
                    );
                  },
                  childCount: dayItems.length,
                ),
              ),
            );
          }

          return CustomScrollView(slivers: slivers);
        },
      ),
    );
  }
}
