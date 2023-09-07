import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi{
    // Trigger the authentication flow
    static final _googleSignIn = GoogleSignIn();

    static Future login() async {
        final GoogleSignInAccount? account = await _googleSignIn.signIn();
        if (account != null) {
          final GoogleSignInAuthentication googleAuth = await account.authentication;
          final String? accessToken = googleAuth.accessToken;
          print('Google Access Token: $accessToken');
        }
        return account;

    }

    static Future logout() => _googleSignIn.disconnect();

  }