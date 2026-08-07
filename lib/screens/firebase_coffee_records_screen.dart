import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summer_iub_app/models/coffee_records_model.dart';
import 'package:summer_iub_app/state_management/coffee_state_management.dart';
import 'package:summer_iub_app/widgets/app_backgroud_design_widget.dart';

// Displays the "coffee_records" Firestore collection in real time using
// snapshots() + StreamBuilder. Any add/update/delete in Firestore (from
// this app, the Firebase console, or another device) shows up instantly.
class FirebaseCoffeeRecordsScreen extends StatelessWidget {
  const FirebaseCoffeeRecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final csm = Provider.of<CoffeeStateManagement>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Firebase Coffee Records",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.00),
        ),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
      ),
      body: AppBackgroudDesignWidget(
        child: StreamBuilder<List<CoffeeRecordsModel>>(
          stream: csm.streamCoffeeRecords(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Something went wrong:\n${snapshot.error}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final records = snapshot.data ?? [];

            if (records.isEmpty) {
              return const Center(
                child: Text(
                  "No coffee records yet.\nTap the + button to add one!",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.brown, fontSize: 16.00),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              itemCount: records.length,
              itemBuilder: (context, index) {
                final CoffeeRecordsModel coffeeRecord = records[index];

                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.coffee),
                    title: Text(coffeeRecord.title),
                    subtitle: Text(
                      "${coffeeRecord.des} - Amount: ${coffeeRecord.amount}",
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        if (coffeeRecord.id != null) {
                          csm.deleteCoffeeRecordFromFirebase(
                              coffeeRecord.id!);
                        }
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),

      // Tap this to add a new coffee record straight to Firebase. Because
      // the list above uses a real-time stream, the new record shows up
      // instantly without needing to refresh anything.
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await csm.addCoffeeRecordToFirebase(
            CoffeeRecordsModel(
              title: "Coffee Record",
              des: "Quick add from Firebase records screen",
              amount: 10.0,
              date: DateTime.now(),
            ),
          );
        },
        child: const Icon(Icons.local_cafe),
      ),
    );
  }
}