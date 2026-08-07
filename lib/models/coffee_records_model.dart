// CoffeeRecordsModel
// Generated in the quicktype.io style (fromJson/toJson) and extended with
// Realtime Database helpers (fromSnapshot/toMap) so it can be used both
// locally and with Firebase Realtime Database.

class CoffeeRecordsModel {
  // Realtime Database key. Null for a record that hasn't been saved yet.
  String? id;
  final String title;
  final String des;
  double? amount;
  final DateTime date;

  CoffeeRecordsModel({
    this.id,
    required this.title,
    required this.des,
    this.amount,
    required this.date,
  });

  // ---------------------------------------------------------------------
  // quicktype-style JSON constructors
  // ---------------------------------------------------------------------

  factory CoffeeRecordsModel.fromJson(Map<String, dynamic> json) =>
      CoffeeRecordsModel(
        id: json["id"]?.toString(),
        title: json["title"],
        des: json["des"],
        amount: (json["amount"] as num?)?.toDouble(),
        date: _parseDate(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "des": des,
        "amount": amount,
        "date": date.toIso8601String(),
      };

  // ---------------------------------------------------------------------
  // Realtime Database helpers
  // ---------------------------------------------------------------------

  // Used when WRITING to Realtime Database (stored as an ISO8601 string,
  // since Realtime Database has no native Timestamp type like Firestore).
  Map<String, dynamic> toMap() => {
        "title": title,
        "des": des,
        "amount": amount,
        "date": date.toIso8601String(),
      };

  // Used when READING a single record from Realtime Database.
  factory CoffeeRecordsModel.fromMap(String id, Map<dynamic, dynamic> map) =>
      CoffeeRecordsModel(
        id: id,
        title: map["title"] ?? "",
        des: map["des"] ?? "",
        amount: (map["amount"] as num?)?.toDouble(),
        date: _parseDate(map["date"]),
      );

  static DateTime _parseDate(dynamic value) {
    if (value is String) return DateTime.parse(value);
    return DateTime.now();
  }
}
