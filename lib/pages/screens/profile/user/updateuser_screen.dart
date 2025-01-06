import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_ecom/core/services/UploadService.dart';
import 'package:flutter_ecom/core/services/UserService.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/DTO/request/UserRequest.dart';
import '../../../../core/DTO/response/userResponse.dart';


class UpdateUserScreen extends StatefulWidget {
  final UserResponse user;

  UpdateUserScreen({Key? key, required this.user}) : super(key: key);

  @override
  _UpdateUserScreenState createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _avatarController;
  File? _image;

  final UploadService _uploadService = UploadService();
  final UserServices _userServices = UserServices();


  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.user.username);
    _emailController = TextEditingController(text: widget.user.email);
    _phoneController = TextEditingController(text: widget.user.phone);
    _avatarController = TextEditingController(text: widget.user.avatar);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _avatarController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    File? selectedImage = await _uploadService.pickImage();
    if (selectedImage != null) {
      setState(() {
        _image = selectedImage;
      });
    }
  }

  Future<void> _updateUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        String? avatarUrl;

        // Nếu người dùng chọn ảnh mới, tải ảnh lên Firebase Storage
        if (_image != null) {
          avatarUrl = await _uploadService.uploadImage(_image!);
        } else {
          // Sử dụng URL hiện tại nếu không có ảnh mới
          avatarUrl = _avatarController.text;
        }

        if (avatarUrl != null) {
          // Tạo DTO để cập nhật thông tin người dùng
          UserRequest request = UserRequest(
            name: _usernameController.text,
            email: _emailController.text,
            phone: _phoneController.text,
            avatar: avatarUrl,
          );

          // Gửi yêu cầu cập nhật
          await _userServices.UpdateUser(request);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Thông tin người dùng đã được cập nhật")),
          );

          // Quay lại màn hình trước
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Lỗi khi tải lên ảnh đại diện")),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Lỗi trong quá trình cập nhật")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cập nhật thông tin cá nhân")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Profile Picture Section
                    Center(
                      child: Column(
                        children: [
                          ClipOval(
                            child: _image != null
                                ? Image.file(
                              _image!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            )
                                : widget.user.avatar.isNotEmpty
                                ? Image.network(
                              widget.user.avatar,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            )
                                : Container(
                              width: 100,
                              height: 100,
                              color: Colors.grey[300],
                              child: const Icon(Icons.account_circle, size: 50),
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton.icon(
                            onPressed: _pickImage,
                            icon: const Icon(Icons.image),
                            label: const Text("Chọn ảnh đại diện"),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Username Field
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: "Tên người dùng",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Vui lòng nhập tên người dùng";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    // Email Field
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Vui lòng nhập email";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    // Phone Field
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: "Số điện thoại",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Vui lòng nhập số điện thoại";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    // Update Button
                    ElevatedButton(
                      onPressed: _updateUser,
                      child: const Text("Cập nhật"),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
