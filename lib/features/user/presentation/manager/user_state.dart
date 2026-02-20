import 'package:equatable/equatable.dart';
import '../../../../core/errors/failure.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {
  const UserInitial();
}

class UserLoading extends UserState {
  const UserLoading();
}

class UserSuccess<T> extends UserState {
  final T data;

  const UserSuccess(this.data);

  UserSuccess<T> copyWith({T? data}) {
    return UserSuccess<T>(data ?? this.data);
  }

  @override
  List<Object?> get props => [data];
}

class UserListSuccess<T> extends UserState {
  final List<T> data;

  const UserListSuccess(this.data);

  UserListSuccess<T> copyWith({List<T>? data}) {
    return UserListSuccess<T>(data ?? this.data);
  }

  @override
  List<Object?> get props => [data];
}

class UserError extends UserState {
  final Failure failure;

  const UserError(this.failure);

  UserError copyWith({Failure? failure}) {
    return UserError(failure ?? this.failure);
  }

  @override
  List<Object?> get props => [failure];
}