import 'package:alphanum_comparator/alphanum_comparator.dart';
import 'package:test/test.dart';

void main() {
  group('Basic sorting functionality', () {
    test('Simple numeric suffix sorting', () {
      final List<String> items = ["Hello 1", "Hello 3", "Hello 10", "Hello 2"];
      items.sort(AlphanumComparator.compare);

      expect(items, ["Hello 1", "Hello 2", "Hello 3", "Hello 10"]);
    });

    test('Mixed prefix sorting', () {
      final List<String> items = ["1A", "9A", "2A", "A1", "A10", "A2"];
      items.sort(AlphanumComparator.compare);

      expect(items, ["1A", "2A", "9A", "A1", "A2", "A10"]);
    });

    test('Mixed numeric and alphabetic sorting', () {
      final List<String> items = ["1A", "10A", "2A", "A1", "A10", "A2"];
      items.sort(AlphanumComparator.compare);

      expect(items, ["1A", "2A", "10A", "A1", "A2", "A10"]);
    });

    test('compareNumFirsts places numbers first', () {
      final List<String> items = ["1A", "10A", "2A", "A1", "A10", "A2"];
      items.sort(AlphanumComparator.compareNumFirsts);

      expect(items, ["1A", "2A", "10A", "A1", "A2", "A10"]);
    });
  });

  group('Advanced sorting scenarios', () {
    test('Multi-digit numbers in different positions', () {
      final List<String> items = ["file10.txt", "file1.txt", "file123.txt", "file2.txt", "file20.txt"];
      items.sort(AlphanumComparator.compare);

      expect(items, ["file1.txt", "file2.txt", "file10.txt", "file20.txt", "file123.txt"]);
    });
  });

  group('Edge cases', () {
    test('Empty strings and null values', () {
      final List<String> items = ["", "A", "", "1", "B"];
      items.sort(AlphanumComparator.compare);

      expect(items, ["", "", "1", "A", "B"]);
    });

    test('Identical strings', () {
      final List<String> items = ["Same", "Same", "Same", "Different", "Same"];
      items.sort(AlphanumComparator.compare);

      expect(items, ["Different", "Same", "Same", "Same", "Same"]);
    });

    test('Single characters', () {
      final List<String> items = ["Z", "1", "a", "A", "9", "z"];
      items.sort(AlphanumComparator.compare);

      expect(items, ["1", "9", "A", "Z", "a", "z"]);
    });

    test('Mixed case strings', () {
      final List<String> items = ["aAA", "AAa", "aaa", "AaA", "AAA"];
      items.sort(AlphanumComparator.compare);

      expect(items, ["AAA", "AAa", "AaA", "aAA", "aaa"]);
    });
  });

  group('Special sorting cases', () {
    test('Strings with leading zeros', () {
      final List<String> items = ["Item 01", "Item 1", "Item 001", "Item 02", "Item 2"];
      items.sort(AlphanumComparator.compare);

      // Leading zeros don't affect the numeric value: equal values compare as 0,
      // so their relative order after sorting is not specified.
      expect(items.sublist(0, 3).toSet(), {"Item 1", "Item 01", "Item 001"});
      expect(items.sublist(3).toSet(), {"Item 2", "Item 02"});
      expect(AlphanumComparator.compare("Item 01", "Item 1"), 0);
      expect(AlphanumComparator.compare("Item 01", "Item 2"), lessThan(0));
      expect(AlphanumComparator.compare("Item 001", "Item 02"), lessThan(0));
    });

    test('File paths and URLs', () {
      final List<String> items = [
        "/folder/file1.txt",
        "/folder/file10.txt",
        "/folder/file2.txt",
        "http://example.com/page1",
        "http://example.com/page10",
        "http://example.com/page2"
      ];
      items.sort(AlphanumComparator.compare);

      expect(items, [
        "/folder/file1.txt",
        "/folder/file2.txt",
        "/folder/file10.txt",
        "http://example.com/page1",
        "http://example.com/page2",
        "http://example.com/page10"
      ]);
    });

    test('Strings with multiple number sequences', () {
      final List<String> items = ["Section 2, Page 10", "Section 2, Page 2", "Section 10, Page 1", "Section 1, Page 10", "Section 1, Page 1"];
      items.sort(AlphanumComparator.compare);

      expect(items, [
        "Section 1, Page 1",
        "Section 1, Page 10",
        "Section 2, Page 2",
        "Section 2, Page 10",
        "Section 10, Page 1",
      ]);
    });
  });

  group('compareNumFirsts specific tests', () {
    test('Basic numeric-first sorting', () {
      final List<String> items = ["B1", "1B", "A2", "2A", "C10", "10C"];
      items.sort(AlphanumComparator.compareNumFirsts);

      expect(items, ["1B", "2A", "10C", "A2", "B1", "C10"]);
    });
  });

  // Add new group for specific implementation details and corner cases
  group('Implementation specific tests', () {
    test('Very long numbers', () {
      final List<String> items = ["File 9999999999999999", "File 1000000000000000", "File 1000000000000001"];
      items.sort(AlphanumComparator.compare);

      expect(items, ["File 1000000000000000", "File 1000000000000001", "File 9999999999999999"]);
    });

    test('Unicode characters', () {
      final List<String> items = [
        "Item 1 \u00E9", // é
        "Item 1 \u00E0", // à
        "Item 2 \u00E9", // é
        "Item 10 \u00E0" // à
      ];
      items.sort(AlphanumComparator.compare);

      expect(items, [
        "Item 1 \u00E0", // à
        "Item 1 \u00E9", // é
        "Item 2 \u00E9", // é
        "Item 10 \u00E0" // à
      ]);
    });
  });

  group('Decimal number sorting', () {
    test('Client reported case: decimal values sorted by numeric value', () {
      final List<String> items = ["1.2", "1.22", "1.21"];
      items.sort(AlphanumComparator.compare);

      expect(items, ["1.2", "1.21", "1.22"]);
    });

    test('Comma as decimal separator', () {
      final List<String> items = ["1,2", "1,22", "1,21"];
      items.sort(AlphanumComparator.compare);

      expect(items, ["1,2", "1,21", "1,22"]);
    });

    test('Decimal numbers within complex strings', () {
      final List<String> items = ["file_v1.10_final", "file_v1.2_final", "file_v1.21_final"];
      items.sort(AlphanumComparator.compare);

      expect(items, ["file_v1.10_final", "file_v1.2_final", "file_v1.21_final"]);
    });

    test('Trailing zeros do not change the decimal value', () {
      expect(AlphanumComparator.compare("1.2", "1.20"), 0);
      expect(AlphanumComparator.compare("1.20", "1.2"), 0);
      expect(AlphanumComparator.compare("1,2", "1.20"), 0);
      expect(AlphanumComparator.compare("1.20", "1.1"), greaterThan(0));
      expect(AlphanumComparator.compare("1.1", "1.20"), lessThan(0));
    });

    test('Equivalent decimals followed by more characters', () {
      expect(AlphanumComparator.compare("1.200", "1.2a"), lessThan(0));
      expect(AlphanumComparator.compare("1.2a", "1.200"), greaterThan(0));
      expect(AlphanumComparator.compare("v1.20_final", "v1.2_final"), 0);
    });

    test('Leading zeros do not change the numeric value', () {
      expect(AlphanumComparator.compare("01.2", "1.20"), 0);
      expect(AlphanumComparator.compare("01,2", "1.2"), 0);
      expect(AlphanumComparator.compare("01.2", "2.0"), lessThan(0));
      expect(AlphanumComparator.compare("2.0", "01.2"), greaterThan(0));
      expect(AlphanumComparator.compare("01", "1"), 0);
      expect(AlphanumComparator.compare("2", "01"), greaterThan(0));
      expect(AlphanumComparator.compare("0.5", "00.50"), 0);
      expect(AlphanumComparator.compare("00.5", "1"), lessThan(0));
    });

    test('Integers and decimals with leading zeros are ordered transitively', () {
      final List<String> items = ["01", "2", "1.5", "10", "01.5", "1", "01.2", "1.20", "2.0", "002", "0.9"];
      for (final String a in items) {
        for (final String b in items) {
          expect(AlphanumComparator.compare(a, b).sign, -AlphanumComparator.compare(b, a).sign);
          for (final String c in items) {
            final int ab = AlphanumComparator.compare(a, b);
            final int bc = AlphanumComparator.compare(b, c);
            if (ab <= 0 && bc <= 0) {
              final int ac = AlphanumComparator.compare(a, c);
              if (ab < 0 || bc < 0) {
                expect(ac, lessThan(0), reason: '$a <= $b <= $c');
              } else {
                expect(ac, 0, reason: '$a == $b == $c');
              }
            }
          }
        }
      }

      items.sort(AlphanumComparator.compare);
      // Sorted by numeric value; equal values may appear in any order.
      expect(items.first, "0.9");
      expect(items.sublist(1, 3).toSet(), {"1", "01"});
      expect(items.sublist(3, 5).toSet(), {"01.2", "1.20"});
      expect(items.sublist(5, 7).toSet(), {"1.5", "01.5"});
      expect(items.sublist(7, 10).toSet(), {"2", "2.0", "002"});
      expect(items.last, "10");
    });

    test('1.9 is greater than 1.10 when compared as decimals', () {
      expect(AlphanumComparator.compare("1.9", "1.10"), greaterThan(0));
      expect(AlphanumComparator.compare("1.10", "1.9"), lessThan(0));

      final List<String> items = ["1.9", "1.10"];
      items.sort(AlphanumComparator.compare);

      expect(items, ["1.10", "1.9"]);
    });

    test('Non-decimal dotted strings keep previous behaviour', () {
      final List<String> items = ["file10.txt", "file1.txt", "file2.txt"];
      items.sort(AlphanumComparator.compare);

      expect(items, ["file1.txt", "file2.txt", "file10.txt"]);
    });
  });

  group('Regression tests', () {
    test('Strings that only differ by a single digit', () {
      final List<String> items = ["abc1def", "abc2def", "abc10def"];
      items.sort(AlphanumComparator.compare);

      expect(items, ["abc1def", "abc2def", "abc10def"]);
    });

    test('Different casing with numbers', () {
      final List<String> items = ["ABC1", "abc2", "ABC10", "abc20"];
      items.sort(AlphanumComparator.compare);

      expect(items, ["ABC1", "ABC10", "abc2", "abc20"]);
    });

    test('Numeric strings right at the edge of string length', () {
      final List<String> items = ["A1", "A2", "A10", "B", "A"];
      items.sort(AlphanumComparator.compare);

      expect(items, [
        "A",
        "A1",
        "A2",
        "A10",
        "B",
      ]);
    });
  });
}
