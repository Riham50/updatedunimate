import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/schedule_model.dart';

class ScheduleService {
  final _collection = FirebaseFirestore.instance.collection('schedule');

  Future<void> addSchedule(ScheduleItem item) async {
    await _collection.add(item.toMap());
  }

  Future<void> deleteSchedule(String id) async {
    await _collection.doc(id).delete();
  }

  // Future<void> updateSchedule(ScheduleItem item) async {
  //   await _collection.doc(item.id).update(item.toMap());
  // }
  Future<void> updateSchedule(ScheduleItem item) async {
  await FirebaseFirestore.instance
      .collection('schedules')
      .doc(item.id)
      .update({
        'day': item.day,
        'period': item.period,
        'courseName': item.courseName,
        'instructor': item.instructor,
      });
}


  Stream<List<ScheduleItem>> getScheduleStream() {
    return _collection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => ScheduleItem.fromMap(doc.id, doc.data()))
        .toList());
  }
}
