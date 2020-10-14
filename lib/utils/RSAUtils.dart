import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:encrypt/encrypt.dart';

import 'dart:async';
import 'dart:convert';

class RSAUtils {

  static Future<String> encodeString(String content,String publicKeyStr) async{
//    var publicKeyStr = await rootBundle.loadString('assets/file/rsa_public_key.pem');
    String pKyy = publicKeyStr;
    publicKeyStr = "-----BEGIN PUBLIC KEY-----\r\n" + pKyy + '\r\n-----END PUBLIC KEY-----';
    var publicKey = RSAKeyParser().parse(publicKeyStr);
    final encrypter = Encrypter(RSA(publicKey: publicKey));
    return await encrypter.encrypt(content).base64.toUpperCase();
  }

  static Future<String> decodeString(String content) async{
    var publicKeyStr = await rootBundle.loadString('assets/file/rsa_private_key.pem');
    var publicKey =  RSAKeyParser().parse(publicKeyStr);
    final encrypter = Encrypter(RSA(publicKey: publicKey));
    return await encrypter.decrypt(Encrypted.fromBase64(content));
  }
}
