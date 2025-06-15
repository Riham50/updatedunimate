// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import '../models/lost_found_item.dart';
// import '../services/lost_found_service.dart';

// class LostFoundScreen extends StatefulWidget {
//   const LostFoundScreen({super.key});

//   @override
//   State<LostFoundScreen> createState() => _LostFoundScreenState();
// }

// class _LostFoundScreenState extends State<LostFoundScreen> {
//   final LostFoundService _service = LostFoundService();
//   String _searchText = '';
//   bool _showFound = false; // false: show lost items, true: show found items

//   void _showAddEditForm({LostFoundItem? item}) {
//     final _formKey = GlobalKey<FormState>();
//     final titleController = TextEditingController(text: item?.title ?? '');
//     final descriptionController = TextEditingController(text: item?.description ?? '');
//     final locationController = TextEditingController(text: item?.location ?? '');
//     final contactController = TextEditingController(text: item?.contact ?? '');
//     DateTime? selectedDate = item?.date ?? DateTime.now();
//     bool isFound = item?.isFound ?? false;

//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (_) => Padding(
//         padding: EdgeInsets.only(
//           bottom: MediaQuery.of(context).viewInsets.bottom,
//           left: 16,
//           right: 16,
//           top: 24,
//         ),
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Text(item == null ? 'Add Item' : 'Edit Item',
//                     style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

//                 TextFormField(
//                   controller: titleController,
//                   decoration: const InputDecoration(labelText: 'Title'),
//                   validator: (val) => val == null || val.isEmpty ? 'Required' : null,
//                 ),

//                 TextFormField(
//                   controller: descriptionController,
//                   decoration: const InputDecoration(labelText: 'Description'),
//                   maxLines: 3,
//                   validator: (val) => val == null || val.isEmpty ? 'Required' : null,
//                 ),

//                 TextFormField(
//                   controller: locationController,
//                   decoration: const InputDecoration(labelText: 'Location'),
//                   validator: (val) => val == null || val.isEmpty ? 'Required' : null,
//                 ),

//                 const SizedBox(height: 8),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Text('Date: ${DateFormat.yMMMd().format(selectedDate!)}'),
//                     ),
//                     TextButton(
//                       onPressed: () async {
//                         final picked = await showDatePicker(
//                           context: context,
//                           initialDate: selectedDate!,
//                           firstDate: DateTime(2000),
//                           lastDate: DateTime(DateTime.now().year + 5),
//                         );
//                         if (picked != null) {
//                           setState(() {
//                             selectedDate = picked;
//                           });
//                         }
//                       },
//                       child: const Text('Pick Date'),
//                     ),
//                   ],
//                 ),

//                 SwitchListTile(
//                   title: const Text('Mark as Found'),
//                   value: isFound,
//                   onChanged: (val) {
//                     setState(() {
//                       isFound = val;
//                     });
//                   },
//                 ),

//                 TextFormField(
//                   controller: contactController,
//                   decoration: const InputDecoration(labelText: 'Contact Info'),
//                   validator: (val) => val == null || val.isEmpty ? 'Required' : null,
//                 ),

//                 const SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: () async {
//                     if (_formKey.currentState!.validate() && selectedDate != null) {
//                       final newItem = LostFoundItem(
//                         id: item?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
//                         title: titleController.text,
//                         description: descriptionController.text,
//                         location: locationController.text,
//                         date: selectedDate!,
//                         isFound: isFound,
//                         contact: contactController.text,
//                       );

//                       if (item == null) {
//                         await _service.addItem(newItem);
//                       } else {
//                         await _service.updateItem(newItem);
//                       }

//                       Navigator.pop(context);
//                     }
//                   },
//                   child: Text(item == null ? 'Add' : 'Update'),
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
//       appBar: AppBar(
//         title: const Text('Lost and Found'),
//         actions: [
//           IconButton(
//             icon: Icon(_showFound ? Icons.check_circle_outline : Icons.search_off),
//             tooltip: _showFound ? 'Show Lost Items' : 'Show Found Items',
//             onPressed: () {
//               setState(() {
//                 _showFound = !_showFound;
//               });
//             },
//           )
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _showAddEditForm(),
//         child: const Icon(Icons.add),
//       ),
//       body: Column(
//         children: [
//           // Search bar
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               decoration: const InputDecoration(
//                 prefixIcon: Icon(Icons.search),
//                 labelText: 'Search by title or location',
//                 border: OutlineInputBorder(),
//               ),
//               onChanged: (value) {
//                 setState(() {
//                   _searchText = value.toLowerCase();
//                 });
//               },
//             ),
//           ),

//           Expanded(
//             child: StreamBuilder<List<LostFoundItem>>(
//               stream: _service.getItemsStream(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

//                 List<LostFoundItem> items = snapshot.data!;

//                 // Filter lost/found and search text
//                 items = items.where((item) {
//                   final matchesStatus = item.isFound == _showFound;
//                   final matchesSearch = item.title.toLowerCase().contains(_searchText) ||
//                       item.location.toLowerCase().contains(_searchText);
//                   return matchesStatus && matchesSearch;
//                 }).toList();

//                 // Sort by date descending (most recent first)
//                 items.sort((a, b) => b.date.compareTo(a.date));

//                 if (items.isEmpty) {
//                   return Center(child: Text(_showFound ? 'No found items.' : 'No lost items.'));
//                 }

//                 return ListView.builder(
//                   itemCount: items.length,
//                   itemBuilder: (context, index) {
//                     final item = items[index];
//                     return Card(
//                       child: ListTile(
//                         title: Text(item.title),
//                         subtitle: Text(
//                             '${item.location} • ${DateFormat.yMMMd().format(item.date)}\nContact: ${item.contact}'),
//                         isThreeLine: true,
//                         trailing: PopupMenuButton<String>(
//                           onSelected: (value) async {
//                             if (value == 'edit') {
//                               _showAddEditForm(item: item);
//                             } else if (value == 'delete') {
//                               final confirm = await showDialog<bool>(
//                                 context: context,
//                                 builder: (context) => AlertDialog(
//                                   title: const Text('Delete Item'),
//                                   content: const Text('Are you sure you want to delete this item?'),
//                                   actions: [
//                                     TextButton(
//                                       onPressed: () => Navigator.pop(context, false),
//                                       child: const Text('Cancel'),
//                                     ),
//                                     TextButton(
//                                       onPressed: () => Navigator.pop(context, true),
//                                       child: const Text('Delete'),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                               if (confirm == true) {
//                                 await _service.deleteItem(item.id);
//                               }
//                             }
//                           },
//                           itemBuilder: (context) => [
//                             const PopupMenuItem(
//                               value: 'edit',
//                               child: Text('Edit'),
//                             ),
//                             const PopupMenuItem(
//                               value: 'delete',
//                               child: Text('Delete'),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/lost_found_item.dart';
import '../services/lost_found_service.dart';

class LostFoundScreen extends StatefulWidget {
  const LostFoundScreen({super.key});

  @override
  State<LostFoundScreen> createState() => _LostFoundScreenState();
}

class _LostFoundScreenState extends State<LostFoundScreen> {
  final LostFoundService _service = LostFoundService();

  void _showItemForm({LostFoundItem? item}) {
    final _formKey = GlobalKey<FormState>();
    final titleController = TextEditingController(text: item?.title ?? '');
    final descriptionController = TextEditingController(text: item?.description ?? '');
    final contactController = TextEditingController(text: item?.contact ?? '');
    String type = item?.type ?? 'lost';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 20,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: type,
                decoration: const InputDecoration(labelText: "Type"),
                items: ['lost', 'found']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e.toUpperCase())))
                    .toList(),
                onChanged: (val) => type = val!,
              ),
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Item Title"),
                validator: (val) => val == null || val.isEmpty ? "Required" : null,
              ),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: "Description"),
                validator: (val) => val == null || val.isEmpty ? "Required" : null,
              ),
              TextFormField(
                controller: contactController,
                decoration: const InputDecoration(labelText: "Contact Info"),
                validator: (val) => val == null || val.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final newItem = LostFoundItem(
                      id: item?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
                      title: titleController.text,
                      description: descriptionController.text,
                      contact: contactController.text,
                      type: type,
                      date: DateTime.now(),
                    );
                    item == null
                        ? await _service.addItem(newItem)
                        : await _service.updateItem(newItem);
                    Navigator.pop(context);
                  }
                },
                child: Text(item == null ? "Add" : "Update"),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lost and Found")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showItemForm(),
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<LostFoundItem>>(
        stream: _service.getItemsStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final allItems = snapshot.data!;
          final lostItems = allItems.where((e) => e.type == 'lost').toList();
          final foundItems = allItems.where((e) => e.type == 'found').toList();

          return ListView(
            children: [
              _buildSection("Lost Items", lostItems),
              _buildSection("Found Items", foundItems),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSection(String title, List<LostFoundItem> items) {
    if (items.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text("No $title yet.", style: const TextStyle(fontSize: 16)),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.blueGrey[50],
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        ...items.map((item) => Card(
              child: ListTile(
                title: Text(item.title),
                subtitle: Text("${item.description}\nContact: ${item.contact}\n${DateFormat.yMMMd().format(item.date)}"),
                isThreeLine: true,
                trailing: PopupMenuButton<String>(
                  onSelected: (value) async {
                    if (value == 'edit') {
                      _showItemForm(item: item);
                    } else if (value == 'delete') {
                      await _service.deleteItem(item.id);
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(value: 'edit', child: Text('Edit')),
                    const PopupMenuItem(value: 'delete', child: Text('Delete')),
                  ],
                ),
              ),
            )),
      ],
    );
  }
}
