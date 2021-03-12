import 'dart:convert';

import 'package:firedart/src/auth/client/key_client.dart';
import 'package:firedart/src/auth/exception/firebase_auth_exception.dart';
import 'package:firedart/src/auth/model/user.dart';
import 'package:firedart/src/auth/token/provider/token_provider.dart';

class AuthGateway {
  final KeyClient client;
  final TokenProvider tokenProvider;

  /// The authentication server URL used to perform auth related requests.
  final String authGatewayUrl;

  /// Creates an instance of [AuthGateway] with the given [client],
  /// [tokenProvider] and [authGatewayUrl].
  ///
  /// Throws an [ArgumentError] if either [client], [tokenProvider] or
  /// [authGatewayUrl] is `null`.
  AuthGateway(this.client, this.tokenProvider, this.authGatewayUrl) {
    ArgumentError.checkNotNull(client, 'client');
    ArgumentError.checkNotNull(tokenProvider, 'tokenProvider');
    ArgumentError.checkNotNull(authGatewayUrl, 'authGatewayUrl');
  }

  Future<User> signUp(String email, String password) async =>
      _auth('signUp', email, password);

  Future<User> signIn(String email, String password) async =>
      _auth('signInWithPassword', email, password);

  Future<void> resetPassword(String email) => _post('sendOobCode', {
        'requestType': 'PASSWORD_RESET',
        'email': email,
      });

  Future<User> _auth(String method, String email, String password) async {
    final body = {
      'email': email,
      'password': password,
      'returnSecureToken': 'true',
    };

    final map = await _post(method, body);
    tokenProvider.setToken(map);
    return User.fromMap(map);
  }

  Future<Map<String, dynamic>> _post(
    String method,
    Map<String, String> body,
  ) async {
    final requestUrl = '$authGatewayUrl/v1/accounts:$method';

    final response = await client.post(
      requestUrl,
      body: body,
    );

    if (response.statusCode != 200) {
      final responseBody = response.body.isNotEmpty
          ? json.decode(response.body) as Map<String, dynamic>
          : null;

      final code = _parseCodeFromJson(responseBody);

      throw FirebaseAuthException.fromCode(code);
    }

    return json.decode(response.body) as Map<String, dynamic>;
  }

  String _parseCodeFromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    final errorMap = json['error'];

    if (errorMap == null) {
      return null;
    }

    return errorMap['message'] as String;
  }
}
