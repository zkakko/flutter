import 'package:sign_in_with_apple/sign_in_with_apple.dart';

signInWithApple() async{
  // from sign_in_with_apple package
  final credential = await SignInWithApple.getAppleIDCredential(
    scopes: [
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName,
    ],
  );
  return credential;
}
/*
SignInWithAppleButton(
onPressed: () async {
final credential = await SignInWithApple.getAppleIDCredential(
scopes: [
AppleIDAuthorizationScopes.email,
AppleIDAuthorizationScopes.fullName,
],
);
userName = [
credential.givenName ?? '',
credential.familyName ?? '',
].join(' ').trim();

userEmail = credential.email ?? '';

print(credential);

// Now send the credential (especially `credential.authorizationCode`) to your server to create a session
// after they have been validated with Apple (see `Integration` section for more information on how to do this)
},
),

 */