import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:summer_iub_app/models/coffee_records_model.dart';

class CoffeeStateManagement with ChangeNotifier {
  // ------------------------------------------------------------------
  // Local, in-memory list (kept from the earlier class demo)
  // ------------------------------------------------------------------
  List<CoffeeRecordsModel> items = [];

  void addData() {
    items.add(
      CoffeeRecordsModel(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: "Coffee Record ${items.length + 1}",
        des: "Details about Coffee Record ${items.length + 1}",
        amount: 10.0,
        date: DateTime.now(),
      ),
    );

    notifyListeners();
  }

  void addCoffeeRecord(CoffeeRecordsModel coffeeRecord) {
    items.add(
      CoffeeRecordsModel(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: coffeeRecord.title,
        des: coffeeRecord.des,
        amount: coffeeRecord.amount,
        date: coffeeRecord.date,
      ),
    );
    notifyListeners();
  }

  // ------------------------------------------------------------------
  // Firebase / Realtime Database
  // ------------------------------------------------------------------

  // Reference to the "coffee_records" node in Realtime Database.
  final DatabaseReference _coffeeRef =
      FirebaseDatabase.instance.ref('coffee_records');

  // CREATE: send a new coffee record to Realtime Database.
  Future<void> addCoffeeRecordToFirebase(
      CoffeeRecordsModel coffeeRecord) async {
    await _coffeeRef.push().set(coffeeRecord.toMap());
    // No notifyListeners() needed here -- the StreamBuilder listening to
    // streamCoffeeRecords() will update automatically in real time.
  }

  // READ: real-time stream of every coffee record, newest first.
  Stream<List<CoffeeRecordsModel>> streamCoffeeRecords() {
    return _coffeeRef.onValue.map((event) {
      final data = event.snapshot.value;
      if (data == null) return <CoffeeRecordsModel>[];

      final Map<dynamic, dynamic> recordsMap = data as Map<dynamic, dynamic>;
      final records = recordsMap.entries
          .map((entry) => CoffeeRecordsModel.fromMap(
              entry.key.toString(), entry.value as Map<dynamic, dynamic>))
          .toList();

      records.sort((a, b) => b.date.compareTo(a.date));
      return records;
    });
  }

  // UPDATE: update an existing coffee record by its Realtime Database key.
  Future<void> updateCoffeeRecordInFirebase(
      CoffeeRecordsModel coffeeRecord) async {
    if (coffeeRecord.id == null) return;
    await _coffeeRef.child(coffeeRecord.id!).update(coffeeRecord.toMap());
  }

  // DELETE: remove a coffee record from Realtime Database by its key.
  Future<void> deleteCoffeeRecordFromFirebase(String id) async {
    await _coffeeRef.child(id).remove();
  }
}
