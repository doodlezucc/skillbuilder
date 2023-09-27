import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:skillbuilder/models/timestamped.dart';

void main() {
  test('Restore timestamped property', () async {
    final timestampedInt = Timestamped<int>(-1);

    // Initialization
    expect(timestampedInt.defaultValue, -1);
    expect(timestampedInt.value, -1);

    // Submit value
    timestampedInt.submit(1);
    expect(timestampedInt.value, 1);

    // Submit value after delay
    await Future.delayed(const Duration(milliseconds: 1));
    timestampedInt.submit(2);
    expect(timestampedInt.value, 2);

    // Restore object from JSON
    final originalJson = jsonDecode(jsonEncode(timestampedInt.toJson()));

    final restoredTimestamped = Timestamped<int>.fromJson(originalJson);
    final restoredJson = jsonDecode(jsonEncode(restoredTimestamped.toJson()));

    expect(originalJson, equals(restoredJson));

    // Clear timestamps
    timestampedInt.clear();
    expect(timestampedInt.value, -1);
  });
}
