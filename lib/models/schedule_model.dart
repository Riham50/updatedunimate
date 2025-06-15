class ScheduleItem {
  final String id;
  final String courseName;
  final String day;
  final String period; // Morning 1, Morning 2, Afternoon 1, Afternoon 2
  final String instructor;

  ScheduleItem({
    required this.id,
    required this.courseName,
    required this.day,
    required this.period,
    required this.instructor,
  });

  factory ScheduleItem.fromMap(String id, Map<String, dynamic> data) {
    return ScheduleItem(
      id: id,
      courseName: data['courseName'],
      day: data['day'],
      period: data['period'],
      instructor: data['instructor'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'courseName': courseName,
      'day': day,
      'period': period,
      'instructor': instructor,
    };
  }
}
