import 'package:dio/dio.dart';
import 'package:pos_merchant/core/constants/api_endpoints.dart';
import 'package:pos_merchant/data/models/user_model.dart';

class AuthDataSource {
  final Dio dio;

  AuthDataSource({required this.dio});

  Future<UserModel> register({
    required String email,
    required String name,
    required String businessName,
    required String mobileNumber,
    required String password,
  }) async {
    final res = await dio.post(
      ApiEndpoints.merchantRegister,
      data: {
        'name': name,
        'businessName': businessName,
        'email': email,
        'mobileNumber': mobileNumber,
        'password': password,
      },
    );
    return UserModel.fromJson(res.data['user']);
  }

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final res = await dio.post(
      ApiEndpoints.merchantLogin,
      data: {'email': email, 'password': password},
    );
    return UserModel.fromJson(res.data['user']);
  }

  Future<UserModel?> getCurrentUser() async {
    final res = await dio.get(ApiEndpoints.merchantCurrentUser);
    return UserModel.fromJson(res.data['user']);
  }

  Future<void> logout() async {
    await dio.get(ApiEndpoints.merchantLogout);
  }
}
