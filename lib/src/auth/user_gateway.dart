import 'dart:convert';

import 'package:firedart/src/auth/client.dart';
import 'package:firedart/src/auth/token_provider.dart';

class UserGateway {
  final UserClient _client;

  UserGateway(KeyClient client, TokenProvider tokenProvider)
      : _client = UserClient(client, tokenProvider);

  Future<void> requestEmailVerification() async => _post('sendOobCode', {
        'requestType': 'VERIFY_EMAIL',
      });

  Future<User> getUser() async {
    final map = await _post('lookup', {});
    return User.fromMap(map['users'][0] as Map<String,dynamic>);
  }

  Future<void> changePassword(String password) async {
    await _post('update', {
      'password': password,
    });
  }

  Future<void> updateProfile(String displayName, String photoUrl) async {
    await _post('update', {
      if (displayName != null) 'displayName': displayName,
      if (photoUrl != null) 'photoUrl': photoUrl,
    });
  }

  Future<void> deleteAccount() async {
    await _post('delete', {});
  }

  Future<Map<String, dynamic>> _post<T>(
      String method, Map<String, String> body) async {
    final requestUrl =
        'https://identitytoolkit.googleapis.com/v1/accounts:$method';

    final response = await _client.post(
      requestUrl,
      body: body,
    );

    return json.decode(response.body) as Map<String,dynamic>;
  }
}

class User {
  final String id;
  final String displayName;
  final String photoUrl;
  final String email;
  final bool emailVerified;

  User.fromMap(Map<String, dynamic> map)
      : id = map['localId'] as String,
        displayName = map['displayName'] as String,
        photoUrl = map['photoUrl'] as String,
        email = map['email'] as String,
        emailVerified = map['emailVerified'] as bool;

  @override
  String toString() =>
      'id: $id, name: $displayName, photo: $photoUrl, email: $email, emailVerified: $emailVerified';
}
