import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/create_user_usecase.dart';
import '../../domain/usecase/delete_user_usecase.dart';
import '../../domain/usecase/get_user_usecase.dart';
import '../../domain/usecase/update_user_usecase.dart';

import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final CreateUserUseCase createUserUseCase;
  final GetUserUseCase getUserUseCase;
  final UpdateUserUseCase updateUserUseCase;
  final DeleteUserUseCase deleteUserUseCase;

  UserCubit({
    required this.createUserUseCase,
    required this.getUserUseCase,
    required this.updateUserUseCase,
    required this.deleteUserUseCase,
  }) : super(const UserInitial());

  Future<void> createUser(user, {required String name}) async {
    emit(const UserLoading());
    final result = await createUserUseCase(user);
    result.fold(
          (failure) => emit(UserError(failure)),
          (data) => emit(UserSuccess(data)),
    );
  }

  Future<void> getUser(int id) async {
    emit(const UserLoading());
    final result = await getUserUseCase(id);
    result.fold(
          (failure) => emit(UserError(failure)),
          (data) => emit(UserSuccess(data)),
    );
  }

  Future<void> updateUser(user) async {
    emit(const UserLoading());
    final result = await updateUserUseCase(user);
    result.fold(
          (failure) => emit(UserError(failure)),
          (data) => emit(UserSuccess(data)),
    );
  }

  Future<void> deleteUser(int id) async {
    emit(const UserLoading());
    final result = await deleteUserUseCase(id);
    result.fold(
          (failure) => emit(UserError(failure)),
          (data) => emit(UserSuccess(data)),
    );
  }
}