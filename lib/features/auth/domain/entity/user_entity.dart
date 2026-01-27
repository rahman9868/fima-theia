class UserEntity {
  final String email;
  final String token;
  final String? refreshToken;
  UserEntity({required this.email, required this.token, this.refreshToken});
}