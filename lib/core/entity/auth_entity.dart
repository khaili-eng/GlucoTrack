class TokenEntity {
  final String accessToken;
  final String tokenType;

  TokenEntity({
    required this.accessToken,
    required this.tokenType,
  });
}

class UserEntity {
  final int id;
  final String name;
  final String email;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    this.createdAt,
    this.updatedAt,
  });
}