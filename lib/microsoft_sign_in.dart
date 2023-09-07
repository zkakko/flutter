import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

signInWithMicrosoft() async {

  String kClientID = "<ClientID>";
  String kRedirectUri = "<redirectUri>";
  String kTenant = "<TenantID>";

  FlutterAppAuth appAuth = FlutterAppAuth();
  final AuthorizationTokenRequest microsoftOAuthConfig =
  AuthorizationTokenRequest(
    kClientID,
    '$kRedirectUri/', // need to add / at the end of uri
    discoveryUrl: 'https://login.microsoftonline.com/$kTenant/v2.0/.well-known/openid-configuration',
    // version of oauth could be found on manifest of Azure Directory
    scopes: ['openid', 'profile', 'email', 'User.read'],
    // also need to check those API permissions in AD
  );

  try {
    final AuthorizationTokenResponse? result =
    await appAuth.authorizeAndExchangeCode(microsoftOAuthConfig);

    final accessToken = result!.accessToken!;
    print('Microsoft Access Token: $accessToken');

    final response = await http.get(
      Uri.parse('https://graph.microsoft.com/v1.0/me'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    ); // use microsoft Graph API get user information
    if (response.statusCode == 200) {

      final Map<String, dynamic> userInfo = json.decode(response.body);

      final String name = userInfo['displayName'] ?? 'no user name';
      final String email = userInfo['mail'] ?? 'no user email';

      print('Name: $name');
      print('Email: $email');
      return userInfo;

    } else {
      print('Failed to get user info. ${response.body} Status code: ${response.statusCode}');
    }


  } catch (error) {
    print('Error during Microsoft OAuth Sign-In: $error');
  }



  }
