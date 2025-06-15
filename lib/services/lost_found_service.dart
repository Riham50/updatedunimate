import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/lost_found_item.dart';

class LostFoundService {
  final _collection = FirebaseFirestore.instance.collection('lost_found');

  Stream<List<LostFoundItem>> getItemsStream() {
    return _collection.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => LostFoundItem.fromMap(doc.data())).toList());
  }

  Future<void> addItem(LostFoundItem item) {
    return _collection.doc(item.id).set(item.toMap());
  }

  Future<void> deleteItem(String id) {
    return _collection.doc(id).delete();
  }

  Future<void> updateItem(LostFoundItem item) {
    return _collection.doc(item.id).update(item.toMap());
  }
}
