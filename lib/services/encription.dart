import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';

String encryptPassword(String password) {
  Uint8List passwordBytes = Uint8List.fromList(utf8.encode(password));
  Digest sha256Result = sha256.convert(passwordBytes);
  String base64Hash = base64.encode(sha256Result.bytes);
  return base64Hash;
}
