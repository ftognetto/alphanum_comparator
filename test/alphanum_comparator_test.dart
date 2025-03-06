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

      expect(items, ["1A", "2A", "A1", "A2", "10A", "A10"]);
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

      // Note: In most natural sort implementations, the number of leading zeros doesn't affect the order
      expect(items, [
        "Item 1",
        "Item 2",
        "Item 01",
        "Item 02",
        "Item 001",
      ]);
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

      expect(items, ["Section 1, Page 1", "Section 2, Page 2", "Section 1, Page 10", "Section 10, Page 1", "Section 2, Page 10"]);
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

  group('Regression tests', () {
    test('Strings that only differ by a single digit', () {
      final List<String> items = ["abc1def", "abc2def", "abc10def"];
      items.sort(AlphanumComparator.compare);

      expect(items, ["abc1def", "abc2def", "abc10def"]);
    });

    test('Different casing with numbers', () {
      final List<String> items = ["ABC1", "abc2", "ABC10", "abc20"];
      items.sort(AlphanumComparator.compare);

      expect(items, ["ABC1", "abc2", "ABC10", "abc20"]);
    });

    test('Numeric strings right at the edge of string length', () {
      final List<String> items = ["A1", "A2", "A10", "B", "A"];
      items.sort(AlphanumComparator.compare);

      expect(items, ["A", "B", "A1", "A2", "A10"]);
    });
  });
}
