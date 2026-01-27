class AuthenticationTokens {
  final String accessToken;
  final String? refreshToken;
  AuthenticationTokens({required this.accessToken, this.refreshToken});

  factory AuthenticationTokens.fromJson(Map<String, dynamic> json) {
    return AuthenticationTokens(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String?,
    );
  }
}
