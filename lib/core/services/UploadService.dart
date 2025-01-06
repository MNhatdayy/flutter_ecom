import 'dart:io';
import 'package:flutter_ecom/core/config/base_client.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_ecom/core/config/config.dart';
import 'package:flutter_ecom/core/utils/api/upload.api.dart';
import 'package:image_picker/image_picker.dart';

class UploadService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final ImagePicker _imagePicker = ImagePicker();
  final BaseClient _baseClient = BaseClient();
  Future<File?> pickImage() async {
    try {
      final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        return File(pickedFile.path);
      }
    } catch (e) {
      print("Lỗi khi chọn ảnh: $e");
    }
    return null;
  }

  Future<String?> uploadImage(File imageFile) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageRef = _firebaseStorage.ref().child('avatars/$fileName');

      // Upload file
      UploadTask uploadTask = storageRef.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;

      // Lấy URL tải về của ảnh
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Lỗi khi upload ảnh: $e");
      return null;
    }
  }
  Future<String?> uploadAvatar(File imageFile) async {
    try{
      final response = await _baseClient.postformData(AppConfig.baseUrl, uploadEnpoints().uploadAvatar, file: imageFile);
      if(response == null) {
        return null;
      }
      print(response);
      return response;
    }catch(e){
      print("Lỗi khi upload ảnh: $e");
      return null;
    }
  }
}
