import 'package:firedart/src/firestore/firestore_gateway.dart';

class TestConfig {
  static const String apiKey = 'Project Settings -> General -> Web API Key';
  static const String projectId = 'Project Settings -> General -> Project ID';
  static const String email = 'you@server.com';
  static const String password = '1234';
}

class FirestoreGatewayStub extends FirestoreGateway {
  FirestoreGatewayStub() : super('projectIdStub');
}