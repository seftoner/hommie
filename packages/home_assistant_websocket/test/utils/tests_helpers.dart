import 'dart:convert';
import 'dart:io';

Future<Map<String, dynamic>> readJsonTestDataFromFile(String filePath) async {
  final jsonString = await File(filePath).readAsString();
  return jsonDecode(jsonString);
}
