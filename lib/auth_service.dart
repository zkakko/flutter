/*
This file is not used
 */
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter_appauth/flutter_appauth.dart';

class AuthService {

  // Google Sign in
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // apple sign in, use sign_in_with_apple package
  Future<UserCredential> signInWithApple(appleCredential) async {
/*
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
*/
    final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode);
    final auth = await FirebaseAuth.instance.signInWithCredential(oauthCredential);
    //print("auth token:------${auth.credential!.accessToken}");
    //print("auth display name: ${auth.user!.displayName}");

    final fixDisplayNameFromApple = [
      appleCredential.givenName ?? '',
      appleCredential.familyName ?? '',
    ].join(' ').trim();

    final userEmail = appleCredential.email ?? '';

    final firebaseUser = auth.user;
    print(firebaseUser);

    if (fixDisplayNameFromApple.length > 0) {
      await firebaseUser?.updateDisplayName(fixDisplayNameFromApple);
    }

    if (userEmail.length > 0) {
      await firebaseUser?.updateEmail(userEmail);
    }

    await firebaseUser?.reload();
    return auth;
    //print(credential);

  }



  }

