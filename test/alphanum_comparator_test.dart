import 'package:alphanum_comparator/alphanum_comparator.dart';
import 'package:test/test.dart';

void main() {
  test('Test', () {
    final List<String> _test = ["Hello 1", "Hello 3", "Hello 10", "Hello 2"];
    _test.sort(AlphanumComparator.compare);

    expect(_test[0], "Hello 1");
    expect(_test[1], "Hello 2");
    expect(_test[2], "Hello 3");
    expect(_test[3], "Hello 10");

    final List<String> _test2 = ["1A", "9A", "2A", "A1", "A10", "A2"];
    _test2.sort(AlphanumComparator.compare);
    expect(_test2[0], "1A");
    expect(_test2[1], "2A");
    expect(_test2[2], "9A");
    expect(_test2[3], "A1");
    expect(_test2[4], "A2");
    expect(_test2[5], "A10");

    final List<String> _test3 = ["1A", "10A", "2A", "A1", "A10", "A2"];
    _test3.sort(AlphanumComparator.compare);
    expect(_test3[0], "1A");
    expect(_test3[1], "2A");
    expect(_test3[2], "A1");
    expect(_test3[3], "A2");
    expect(_test3[4], "10A");
    expect(_test3[5], "A10");

    final List<String> _test4 = ["1A", "10A", "2A", "A1", "A10", "A2"];
    _test4.sort(AlphanumComparator.compareNumFirsts);
    expect(_test4[0], "1A");
    expect(_test4[1], "2A");
    expect(_test4[2], "10A");
    expect(_test4[3], "A1");
    expect(_test4[4], "A2");
    expect(_test4[5], "A10");
  });
}
