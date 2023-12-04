import 'dart:convert';
import 'dart:typed_data';

import 'package:blowfish_ecb/blowfish_ecb.dart';
import 'package:uuid/uuid.dart';

String secretKey = 'crackegg1996';

String code() {
  return 'duymaiotsv-${DateTime.now().microsecondsSinceEpoch}-${const Uuid().v4().replaceAll('-', '')}';
}

String encryptBlowfish() {
  final blowfish = BlowfishECB(Uint8List.fromList(utf8.encode(secretKey)));
  final encryptedData = blowfish.encode(padPKCS5(utf8.encode(code())));

  return encryptedData.toString();
}

String hexEncode(List<int> bytes) =>
    bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();

String decryptBlowfish(List<int> encryptedData) {
  final blowfish = BlowfishECB(Uint8List.fromList(utf8.encode(secretKey)));

  var decryptedData = blowfish.decode(encryptedData);
  // Remove PKCS5 padding.
  decryptedData = decryptedData.sublist(
      0, decryptedData.length - getPKCS5PadCount(decryptedData));
  return utf8.decode(decryptedData);
}

Uint8List padPKCS5(List<int> input) {
  final inputLength = input.length;
  final paddingValue = 8 - (inputLength % 8);
  final outputLength = inputLength + paddingValue;

  final output = Uint8List(outputLength);
  for (var i = 0; i < inputLength; ++i) {
    output[i] = input[i];
  }
  output.fillRange(outputLength - paddingValue, outputLength, paddingValue);

  return output;
}

int getPKCS5PadCount(List<int> input) {
  if (input.length % 8 != 0) {
    throw FormatException('Block size is invalid!', input);
  }

  final count = input.last;
  final paddingStartIndex = input.length - count;
  for (var i = input.length - 1; i >= paddingStartIndex; --i) {
    if (input[i] != count) {
      throw const FormatException('Padding is not valid PKCS5 padding!');
    }
  }

  return count;
}
