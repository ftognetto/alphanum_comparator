import 'package:flutter_test/flutter_test.dart';

import 'package:alphanum_comparator/alphanum_comparator.dart';

void main() {
  test('Test', () {
    final List<String> _test = ["Hello 1", "Hello 3", "Hello 10", "Hello 2"];
    _test.sort(AlphanumComparator.compare);

    expect(_test[0], "Hello 1");
    expect(_test[1], "Hello 2");
    expect(_test[2], "Hello 3");
    expect(_test[3], "Hello 10");
    
  });
}
