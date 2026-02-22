class CreateUserParams {
  final String name;
  final String email;
  final String password;

  const CreateUserParams({
    required this.name,
    required this.email,
    required this.password,
  });
}