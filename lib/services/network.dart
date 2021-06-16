import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';

const String _privateKey = '096ea8c653dba0467745a19a6cb7f95aef0237a9';
const String _publicKey = 'c8d746d1d89af2e29a3690e452f0d5cb';
String host = 'https://gateway.marvel.com';
var timeStamp;
var hash;

//Get the timestamp
void getTimeStamp() {
  timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
}

//Get hash

String generateMd5(String data) {
  var content = new Utf8Encoder().convert(data);
  var digest = md5.convert(content);
  // This is actually digest.toString()
  hash = hex.encode(digest.bytes);
  return hash;
}

Future<List<dynamic>> getCharacters() async {
  String _characterHost = '/v1/public/characters';
  getTimeStamp();
  generateMd5(timeStamp + _privateKey + _publicKey);

  Map<String, dynamic> paras = {
    "ts": timeStamp,
    "apikey": _publicKey,
    "hash": hash,
  };

  Dio dio = Dio();
  print((host + _characterHost + '?ts=' + timeStamp + '&apikey=' + _publicKey + '&hash=' + hash));
  final response = await dio.get(host + _characterHost, queryParameters: paras);
  final userMap = json.decode(response.toString())['data']['results'];
  print(userMap.toString());
  return userMap;
}

Future<List<dynamic>> getMoreCharacters() async {
  String _characterHost = '/v1/public/characters';
  getTimeStamp();
  generateMd5(timeStamp + _privateKey + _publicKey);

  Map<String, dynamic> paras = {
    "ts": timeStamp,
    "apikey": _publicKey,
    "hash": hash,
  };

  Dio dio = Dio();
  print((host + _characterHost + '?ts=' + timeStamp + '&apikey=' + _publicKey + '&hash=' + hash));
  final response = await dio.get(host + _characterHost, queryParameters: paras);
  final userMap = json.decode(response.toString())['data']['results'];
  print(userMap.toString());
  return userMap;
}

Future<List<dynamic>> getComics(int id) async {
  String _characterHost = '/v1/public/characters/$id/comics';
  getTimeStamp();
  generateMd5(timeStamp + _privateKey + _publicKey);

  Map<String, dynamic> paras = {
    "ts": timeStamp,
    "apikey": _publicKey,
    "hash": hash,
  };

  Dio dio = Dio();
  final response = await dio.get(host + _characterHost, queryParameters: paras);
  final userMap = json.decode(response.toString())['data']['results'];
  return userMap;
}

Future<List<dynamic>> getSeries(int id) async {
  String _characterHost = '/v1/public/characters/$id/series';
  getTimeStamp();
  generateMd5(timeStamp + _privateKey + _publicKey);

  Map<String, dynamic> paras = {
    "ts": timeStamp,
    "apikey": _publicKey,
    "hash": hash,
  };

  Dio dio = Dio();
  final response = await dio.get(host + _characterHost, queryParameters: paras);
  final userMap = json.decode(response.toString())['data']['results'];
  return userMap;
}

Future<List<dynamic>> getStories(int id) async {
  String _characterHost = '/v1/public/characters/$id/stories';
  getTimeStamp();
  generateMd5(timeStamp + _privateKey + _publicKey);

  Map<String, dynamic> paras = {
    "ts": timeStamp,
    "apikey": _publicKey,
    "hash": hash,
  };

  Dio dio = Dio();
  final response = await dio.get(host + _characterHost, queryParameters: paras);
  final userMap = json.decode(response.toString())['data']['results'];
  return userMap;
}

Future<List<dynamic>> getEvents(int id) async {
  String _characterHost = '/v1/public/characters/$id/events';
  getTimeStamp();
  generateMd5(timeStamp + _privateKey + _publicKey);

  Map<String, dynamic> paras = {
    "ts": timeStamp,
    "apikey": _publicKey,
    "hash": hash,
  };

  Dio dio = Dio();
  final response = await dio.get(host + _characterHost, queryParameters: paras);
  final userMap = json.decode(response.toString())['data']['results'];
  return userMap;
}

Future<List<dynamic>> searchingHero(String name) async {
  String _characterHost = '/v1/public/characters';
  getTimeStamp();
  generateMd5(timeStamp + _privateKey + _publicKey);

  Map<String, dynamic> paras = {
    "nameStartsWith": name,
    "ts": timeStamp,
    "apikey": _publicKey,
    "hash": hash,
  };

  Dio dio = Dio();
  final response = await dio.get(host + _characterHost, queryParameters: paras);
  final userMap = json.decode(response.toString())['data']['results'];
  return userMap;
}
