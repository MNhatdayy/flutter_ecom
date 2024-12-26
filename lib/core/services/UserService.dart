import 'package:flutter_ecom/core/DTO/request/userRequest.dart';
import 'package:flutter_ecom/core/DTO/response/userResponse.dart';
import 'package:flutter_ecom/core/config/base_client.dart';
import 'package:flutter_ecom/core/config/config.dart';
import 'package:flutter_ecom/core/utils/user.api.dart';

class UserServices{
  final BaseClient _baseClient = BaseClient();
  Future<UserResponse> UpdateUser(UserRequest request) async{
    try{
      final response = await _baseClient.put(AppConfig.baseUrl, userEnpoints().updateUser, request);
      if(response != null){
        return UserResponse.fromJson(response);
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