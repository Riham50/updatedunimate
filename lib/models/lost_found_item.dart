class LostFoundItem {
  final String id;
  final String title;
  final String description;
  final String type; // 'lost' or 'found'
  final String contact;
  final DateTime date;

  LostFoundItem({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.contact,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': type,
      'contact': contact,
      'date': date.toIso8601String(),
    };
  }

  factory LostFoundItem.fromMap(Map<String, dynamic> map) {
    return LostFoundItem(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      type: map['type'],
      contact: map['contact'],
      date: DateTime.parse(map['date']),
    );
  }
}
