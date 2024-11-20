import 'package:flutter/cupertino.dart';

extension DateTimeExtensions on DateTime {
  /// Converts a DateTime to a formatted string in 'yyyy-MM-dd'
  String toFormattedString() {
    return '${year.toString().padLeft(4, '0')}-'
        '${month.toString().padLeft(2, '0')}-'
        '${day.toString().padLeft(2, '0')}';
  }
}

extension StringExtensions on String {
  /// Converts a 'yyyy-MM-dd' formatted string back to DateTime
  DateTime? toDateTime() {
    try {
      final parts = split('-');
      if (parts.length == 3) {
        int year = int.parse(parts[0]);
        int month = int.parse(parts[1]);
        int day = int.parse(parts[2]);
        return DateTime(year, month, day);
      }
    } catch (e) {
      debugPrint("$e");
    }
    return null;
  }
}
