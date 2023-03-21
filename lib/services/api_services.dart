import 'dart:convert';
import 'dart:io';

import 'package:chatgpt/models/models_model.dart';
import 'package:http/http.dart' as http;

import '../constants/api_constants.dart';

class ApiService {
  static Future<List<ModelsModel>> getModels () async{
    try {
      var response = await http.get(
        Uri.parse("$BASE_URL/models"),
        headers: {'Authorization': 'Bearer $API_KEY'},
      );

      Map jsonResponse = jsonDecode(response.body);

      if(jsonResponse['error'] != null){
        throw HttpException(jsonResponse['error']['message']);
      }

      List temp = [];
      for(var value in jsonResponse["data"]){
        temp.add(value);
      }
      return ModelsModel.modelsFromSnapshot(temp);
    } catch (error) {
      print("Error: $error");
      rethrow;
    }
  }
}