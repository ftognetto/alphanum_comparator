library alphanum_comparator;

class AlphanumComparator {
  static bool _isDigit(String ch) {
    return (ch.codeUnitAt(0) >= 48) && (ch.codeUnitAt(0) <= 57);
  }

  static bool _isDecimalSeparator(String ch) {
    return ch == '.' || ch == ',';
  }

  /// Compares two strings made only of digits: by length first, then digit by digit.
  /// Leading zeros are kept significant ("2" < "01"), as in previous versions.
  static int _compareDigits(String a, String b) {
    final int result = a.length - b.length;
    if (result != 0) return result;
    return a.compareTo(b);
  }

  /// Compares two numeric chunks, optionally containing a decimal separator (. or ,).
  /// The integer parts are compared with [_compareDigits]; on a tie the fractional
  /// parts are compared by value (trailing zeros ignored, so "1.2" == "1.20").
  /// Strings are compared digit-wise, so no precision is lost on long numbers.
  static int _compareNumericChunks(String a, String b) {
    final List<String> aParts = a.split(RegExp('[.,]'));
    final List<String> bParts = b.split(RegExp('[.,]'));

    final int result = _compareDigits(aParts[0], bParts[0]);
    if (result != 0) return result;

    final String aFraction = aParts.length > 1 ? aParts[1].replaceFirst(RegExp(r'0+$'), '') : '';
    final String bFraction = bParts.length > 1 ? bParts[1].replaceFirst(RegExp(r'0+$'), '') : '';
    return aFraction.compareTo(bFraction);
  }

  static String _getChunk(String s, int sLength, int marker) {
    final StringBuffer chunk = StringBuffer();
    String c = s.substring(marker, marker + 1);
    chunk.write(c);
    marker++;
    if (_isDigit(c)) {
      bool decimalSeparatorFound = false;
      while (marker < sLength) {
        c = s.substring(marker, marker + 1);
        if (_isDigit(c)) {
          chunk.write(c);
          marker++;
          continue;
        }
        if (!decimalSeparatorFound &&
            _isDecimalSeparator(c) &&
            marker + 1 < sLength &&
            _isDigit(s.substring(marker + 1, marker + 2))) {
          decimalSeparatorFound = true;
          chunk.write(c);
          marker++;
          continue;
        }
        break;
      }
    } else {
      while (marker < sLength) {
        c = s.substring(marker, marker + 1);
        if (_isDigit(c)) break;
        chunk.write(c);
        marker++;
      }
    }
    return chunk.toString();
  }

  /// Compare using alphanum algorithm
  static int compare(String s1, String s2) {
    int thisMarker = 0;
    int thatMarker = 0;
    final int s1Length = s1.length;
    final int s2Length = s2.length;

    while (thisMarker < s1Length && thatMarker < s2Length) {
      final String thisChunk = _getChunk(s1, s1Length, thisMarker);
      thisMarker += thisChunk.length;

      final String thatChunk = _getChunk(s2, s2Length, thatMarker);
      thatMarker += thatChunk.length;

      // If both chunks contain numeric characters, sort them numerically
      final int result;
      if (_isDigit(thisChunk) && _isDigit(thatChunk)) {
        result = _compareNumericChunks(thisChunk, thatChunk);
      } else {
        result = thisChunk.compareTo(thatChunk);
      }

      if (result != 0) return result;
    }

    // All compared chunks are equivalent: the string with remaining characters comes last.
    // Chunks can be equivalent without being identical (e.g. "1.2" and "1.20"), so the
    // remaining characters are checked instead of the original lengths.
    // At least one of the two is exhausted here, so the difference has the right sign.
    return (s1Length - thisMarker) - (s2Length - thatMarker);
  }

  /// Compare using alphanum algorithm, but sort strings starting with a number firsts
  static int compareNumFirsts(String s1, String s2) {
    RegExp numberRegEx = RegExp(r'[0-9]');
    bool isS1startWithNumber = s1.startsWith(numberRegEx);
    bool isS2startWithNumber = s2.startsWith(numberRegEx);

    if (isS1startWithNumber && !isS2startWithNumber) {
      return -1;
    } else if (isS2startWithNumber && !isS1startWithNumber) {
      return 1;
    }
    return compare(s1, s2);
  }
}
