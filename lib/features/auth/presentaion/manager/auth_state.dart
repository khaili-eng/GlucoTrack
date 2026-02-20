import 'package:equatable/equatable.dart';
import '../../../../core/errors/failure.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthSuccess<T> extends AuthState {
  final T data;

  const AuthSuccess(this.data);

  AuthSuccess<T> copyWith({T? data}) {
    return AuthSuccess<T>(data ?? this.data);
  }

  @override
  List<Object?> get props => [data];
}

class AuthListSuccess<T> extends AuthState {
  final List<T> data;

  const AuthListSuccess(this.data);

  AuthListSuccess<T> copyWith({List<T>? data}) {
    return AuthListSuccess<T>(data ?? this.data);
  }

  @override
  List<Object?> get props => [data];
}

class AuthError extends AuthState {
  final Failure failure;

  const AuthError(this.failure);

  AuthError copyWith({Failure? failure}) {
    return AuthError(failure ?? this.failure);
  }

  @override
  List<Object?> get props => [failure];
}