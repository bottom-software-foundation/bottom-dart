library bottom;

import 'dart:convert';

// Making values for use later
Map<String, int> _charValues = {
  '🫂': 200,
  '💖': 50,
  '✨': 10,
  '🥺': 5,
  ',': 1,
};

const _null = '\u2764';
const _sectionSeparator = '👉👈';
final _terminator = RegExp('$_sectionSeparator?\$');

// Encodes string to bottom
class BottomEncoder extends Converter<String, String> {
  String _encodeByte(int value) {
    if (value == 0) return '';
    final largest =
        _charValues.entries.firstWhere((entry) => value >= entry.value);
    return largest.key + _encodeByte(value - largest.value);
  }

  String encodeByte(int value) {
    return value == 0 ? _null : _encodeByte(value);
  }

  @override
  String convert(String input) {
    return utf8
        .encode(input)
        .map((value) => encodeByte(value) + _sectionSeparator)
        .join();
  }
}

// Decodes bottom to top readable text
class BottomDecoder extends Converter<String, String> {
  @override
  String convert(String input) {
    var codes = List<int>.empty(growable: true);

    for (var char
        in input.trim().replaceAll(_terminator, '').split(_sectionSeparator)) {
      var code = 0;
      char.runes.forEach((element) {
        code += _charValues[String.fromCharCode(element)] ??= 0;
      });
      codes.add(code);
    }

    return utf8.decode(codes);
  }
}

class BottomCodec extends Codec<String, String> {
  @override
  BottomEncoder get encoder => BottomEncoder();

  @override
  BottomDecoder get decoder => BottomDecoder();
}

final bottom = BottomCodec();
