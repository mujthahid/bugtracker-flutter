import 'dart:convert';
import 'dart:io';
import 'package:bugtracker_client/constants.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../Model_Class/hive_model.dart';


class DataProvider with ChangeNotifier{

  

 List<Map<String,dynamic>> _data =[];
 List<Map<String, dynamic>> get data => _data;

Future<List<Map<String, dynamic>>> getData() async {
  final url = Uri.parse("$BASE_URL/getall");
  final box = Hive.box<ResponseData>('response_data');

  // Check network connectivity
 if (await InternetConnectionChecker().hasConnection) {
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
         _data = (jsonDecode(response.body) as List)
            .map((e) => e as Map<String, dynamic>)
            .toList();

        // Clear existing data in Hive box and add new data
        await box.clear();
        for (final data in _data) {
          final responseData = ResponseData.fromJson(data);
          await box.add(responseData).catchError((error) {
            // Handle error appropriately, e.g. log error or show error message to user
          });
        }

        notifyListeners();
        return _data;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      if (error is SocketException) {
        throw Exception('Unable to connect to server');
      } else {
        rethrow;
      }
    }
  } else {
    // If there is no network connectivity, load data from Hive database
    _data = box.values.map((e) => e.toJson()).toList();
    notifyListeners();
    return _data;
  }
}


Future<void> deleteData(String id) async {
  final url = Uri.parse('$BASE_URL/delete/$id');

  try {
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      _data.removeWhere((element) => element['_id'] == id);
      notifyListeners();
    } else {
      throw Exception(response.body.toString());
    }
  } catch (error) {
    throw Exception('Failed to delete data: $error');
  }
}


Future<void> postData(Map<String, dynamic> postingData) async {
  try {
    final response = await http.post(Uri.parse('$BASE_URL/create'), body: postingData);

    if (response.statusCode == 200) {
      notifyListeners();
    } else {
      throw Exception('Failed to post data: ${response.body}');
    }
  } catch (error) {
    throw Exception('Failed to post data: $error');
  }
}



Future<void> updateData(String id, Map<String, dynamic> postingData) async {
  try {
    final response = await http.patch(Uri.parse('$BASE_URL/update/$id'), body: postingData);

    if (response.statusCode == 200) {
      notifyListeners();
    } else {
      throw Exception('Failed to update data: ${response.body}');
    }
  } catch (error) {
    throw Exception('Failed to update data: $error');
  }
}





}