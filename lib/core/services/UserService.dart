import 'dart:convert';

import 'package:flutter_ecom/core/DTO/request/UserRequest.dart';
import 'package:flutter_ecom/core/DTO/response/userResponse.dart';
import 'package:flutter_ecom/core/config/base_client.dart';
import 'package:flutter_ecom/core/config/config.dart';
import 'package:flutter_ecom/core/utils/api/user.api.dart';

class UserServices{
  final BaseClient _baseClient = BaseClient();
  Future<UserResponse> UpdateUser(int id ,UserRequest request) async{
    try{
      final response = await _baseClient.put(AppConfig.baseUrl, userEnpoints().updateUser+"/${id}", request);
      if(response != null){
        final Map<String, dynamic> jsonResponse = jsonDecode(response);
        return UserResponse.fromJson(jsonResponse);
      }else{
        throw Exception('Không nhận được phản hồi từ server');
      }
    }catch (e){
      print("Có lỗi khi xảy: $e");
      throw Exception('Lỗi trong quá trình cập nhật');
    }
  }
  Future<bool> Delete(int id) async{
    try{
      final response = await _baseClient.delete(AppConfig.baseUrl, userEnpoints().deleteUser+"/$id");
      if(response != null){
        return true;
      }else{
        throw Exception('Không nhận được phản hồi từ server');
      }
    }catch (e){
      print("Có lỗi khi xảy: $e");
      throw Exception('Lỗi trong quá trình cập nhật');
    }
  }
}