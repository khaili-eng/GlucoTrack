import 'package:dio/dio.dart';
import 'package:untitled10/features/user/data/models/user_model.dart';
import 'package:untitled10/features/user/domain/create_user_parametres.dart';

import '../../../../core/entity/auth_entity.dart';
import '../../../../core/network/dio_client.dart';

import '../../../../core/network/end_point.dart';
import '../../../auth/data/models/response_model.dart';


class UserRemoteDataSource {
  final Dio _dio = DioClient().dio;

  Future<ResponseModel<UserEntity>> createUser(CreateUserParams params) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.user,
        data: {
          'name': params.name,
          'email': params.email,
          'password': params.password,
        },
      );
      if (response.statusCode == 201) {
        return ResponseModel.success(UserModel.fromJson(response.data), statusCode: 201);
      } else if (response.statusCode == 422) {
        return ResponseModel.failure('Validation error', statusCode: 422);
      }
      return ResponseModel.failure('Unknown error', statusCode: response.statusCode);
    } on DioException catch (e) {
      return ResponseModel.failure(e.message ?? 'Network error', statusCode: e.response?.statusCode);
    }
  }

  Future<ResponseModel<UserEntity>> getUser(int id) async {
    try {
      final response = await _dio.get('/user/$id');
      if (response.statusCode == 200) {
        return ResponseModel.success(UserModel.fromJson(response.data), statusCode: 200);
      } else if (response.statusCode == 404) {
        return ResponseModel.failure('User not found', statusCode: 404);
      }
      return ResponseModel.failure('Unknown error', statusCode: response.statusCode);
    } on DioException catch (e) {
      return ResponseModel.failure(e.message ?? 'Network error', statusCode: e.response?.statusCode);
    }
  }

  Future<ResponseModel<UserEntity>> updateUser(UserEntity user) async {
    try {
      final response = await _dio.put(
        '/user/${user.id}',
        data: UserModel(
          id: user.id,
          name: user.name,
          email: user.email,
        ).toJson(),
      );
      if (response.statusCode == 200) {
        return ResponseModel.success(UserModel.fromJson(response.data), statusCode: 200);
      } else if (response.statusCode == 422) {
        return ResponseModel.failure('Validation error', statusCode: 422);
      }
      return ResponseModel.failure('Unknown error', statusCode: response.statusCode);
    } on DioException catch (e) {
      return ResponseModel.failure(e.message ?? 'Network error', statusCode: e.response?.statusCode);
    }
  }

  Future<ResponseModel<bool>> deleteUser(int id) async {
    try {
      final response = await _dio.delete('/user/$id');
      if (response.statusCode == 200 || response.statusCode == 204) {
        return ResponseModel.success(true, statusCode: response.statusCode);
      } else if (response.statusCode == 404) {
        return ResponseModel.failure('User not found', statusCode: 404);
      }
      return ResponseModel.failure('Unknown error', statusCode: response.statusCode);
    } on DioException catch (e) {
      return ResponseModel.failure(e.message ?? 'Network error', statusCode: e.response?.statusCode);
    }
  }
}
