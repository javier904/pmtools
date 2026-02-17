void main() {
  print('Testing UserStoryModel parsing logic...');

  int? _parseStoryPoints(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toInt();
    if (value is String) {
      if (value.trim().isEmpty) return null;
      // Remove text suffix like " pts" or " sp"
      final cleanValue = value.replaceAll(RegExp(r'[^\d.,]'), '').replaceAll(',', '.');
      return int.tryParse(cleanValue) ?? double.tryParse(cleanValue)?.toInt();
    }
    return null;
  }

  int? _resolveStoryPoints(dynamic pointsValue, dynamic estimateValue) {
    final points = _parseStoryPoints(pointsValue);
    final estimate = _parseStoryPoints(estimateValue);

    // If points is null or 0, and we have a valid estimate > 0, use the estimate
    if ((points == null || points == 0) && estimate != null && estimate > 0) {
      return estimate;
    }
    // Otherwise return points (even if 0) or null
    return points;
  }

  void test(String label, dynamic points, dynamic estimate, int? expected) {
    final result = _resolveStoryPoints(points, estimate);
    final status = result == expected ? 'PASS' : 'FAIL';
    print('$status: $label (Points: $points, Estimate: $estimate) -> Expected: $expected, Got: $result');
  }

  test('Standard Int', 5, null, 5);
  test('String Int', "3", null, 3);
  test('String Text Suffix', "1 pts", null, 1);
  test('String Text Suffix Space', "8 sp", null, 8);
  test('String Decimal', "3.0", null, 3); // 3.0 -> 3
  test('Fallback to Estimate (Points Null)', null, "13", 13);
  test('Fallback to Estimate (Points 0)', 0, "21 pts", 21);
  test('Fallback to Estimate (Points 0String)', "0", "8", 8);
  test('Priority to Points', 5, "3", 5);
  test('Priority to Points (String)', "5 pts", "3", 5);
  test('Invalid String', "Must Have", null, null);
  test('Invalid Estimate String', null, "Not Estimated", null);
  test('Empty String', "", "", null);
  test('Mixed with Nulls', null, null, null);
  test('Points 0 and Estimate Null', 0, null, 0);
  test('Points Null and Estimate 0', null, 0, null); // 0 estimate ignored? No, returned as null because points is null and estimate is 0 (not > 0)
}
