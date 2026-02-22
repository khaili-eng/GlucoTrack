import 'package:dio/dio.dart';
import 'package:untitled10/features/auth/data/models/auth_model.dart';
import 'package:untitled10/features/auth/data/models/response_model.dart';

import '../../../../core/network/dio_client.dart';
import '../../../../core/network/end_point.dart';
import '../../domain/entities/auth_entity.dart';


class AuthRemoteDataSource {
  final Dio _dio = DioClient().dio;

  Future<ResponseModel<AuthEntity>> login({required String email, required String password}) async {
    try {
      final formData = FormData.fromMap({
        'email': email,
        'password': password,
        'grant_type': 'password',
      });
      final response = await _dio.post(
        ApiEndpoints.login,
        data: formData,
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      if (response.statusCode == 200) {
        return ResponseModel.success(AuthModel.fromJson(response.data), statusCode: 200);
      } else if (response.statusCode == 422) {
        return ResponseModel.failure('Validation error', statusCode: 422);
      }
      return ResponseModel.failure('Unknown error', statusCode: response.statusCode);
    } on DioException catch (e) {
      return ResponseModel.failure(e.message ?? 'Network error', statusCode: e.response?.statusCode);
    }
  }

  Future<ResponseModel<dynamic>> createUser(Map<String, dynamic> body) async {
    try {
      final response = await _dio.post(ApiEndpoints.user, data: body);
      if (response.statusCode == 201) {
        return ResponseModel.success(response.data, statusCode: 201);
      } else if (response.statusCode == 422) {
        return ResponseModel.failure('Validation error', statusCode: 422);
      }
      return ResponseModel.failure('Unknown error', statusCode: response.statusCode);
    } on DioException catch (e) {
      return ResponseModel.failure(e.message ?? 'Network error', statusCode: e.response?.statusCode);
    }
  }

  Future<ResponseModel<dynamic>> forgotPassword({required String email}) async {
    try {
      final response = await _dio.post(ApiEndpoints.otpForgotPassword, data: {'email': email});
      if (response.statusCode == 200) {
        return ResponseModel.success(response.data, statusCode: 200);
      } else if (response.statusCode == 422) {
        return ResponseModel.failure('Validation error', statusCode: 422);
      }
      return ResponseModel.failure('Unknown error', statusCode: response.statusCode);
    } on DioException catch (e) {
      return ResponseModel.failure(e.message ?? 'Network error', statusCode: e.response?.statusCode);
    }
  }

  Future<ResponseModel<dynamic>> verifyOtp({required String email, required String otp}) async {
    try {
      final response = await _dio.post(ApiEndpoints.otpVerify, data: {'email': email, 'otp': otp});
      if (response.statusCode == 200) {
        return ResponseModel.success(response.data, statusCode: 200);
      } else if (response.statusCode == 422) {
        return ResponseModel.failure('Validation error', statusCode: 422);
      }
      return ResponseModel.failure('Unknown error', statusCode: response.statusCode);
    } on DioException catch (e) {
      return ResponseModel.failure(e.message ?? 'Network error', statusCode: e.response?.statusCode);
    }
  }

  Future<ResponseModel<dynamic>> resetPassword({required String email, required String newPassword}) async {
    try {
      final response = await _dio.post(ApiEndpoints.otpResetPassword, data: {'email': email, 'new_password': newPassword});
      if (response.statusCode == 200) {
        return ResponseModel.success(response.data, statusCode: 200);
      } else if (response.statusCode == 422) {
        return ResponseModel.failure('Validation error', statusCode: 422);
      }
      return ResponseModel.failure('Unknown error', statusCode: response.statusCode);
    } on DioException catch (e) {
      return ResponseModel.failure(e.message ?? 'Network error', statusCode: e.response?.statusCode);
    }
  }
}
