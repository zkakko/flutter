import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:sign_in/auth_service.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'google_sign_in.dart';
import 'apple_sign_in.dart';
import 'microsoft_sign_in.dart';

String? userName;
String? userEmail;
String? loginPlatform;
String loginStatus = 'not log in';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    //Firebase.initializeApp().whenComplete(() {
      //print("completed initialization");
      //setState(() {});
    //});
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.indigo[200],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SignInButton(
                  Buttons.Google,
                  mini: false,
                  onPressed: () async {
                    final user = await GoogleSignInApi.login(); // return type: GoogleSignInAccount
                    setState((){
                      userName = user!.displayName;
                      userEmail = user!.email;
                      loginPlatform = 'Google';
                      loginStatus = 'logged in';
                    });
                        },
                        /*
                        async {
                          try {
                            UserCredential auth = await AuthService().signInWithGoogle();
                            if (auth != null) {
                              setState(() {
                                userName = auth.user!.displayName;
                                userEmail = auth.user!.email;
                                loginPlatform = 'google';
                              });
                              print('-------google credential--------$auth');
                            }
                          } catch (e) {
                            print(e);
                          }
                        },

                         */
                      ),
              ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SignInButton(
              Buttons.Apple,
              mini: false,
              onPressed: () async {
                final credential = await signInWithApple();
                print('apple credential: $credential');
                if (credential != null) {
                  print('apple identityToken: ${credential.identityToken}');
                  userName = [
                    credential.givenName ?? '',
                    credential.familyName ?? '',
                  ].join(' ').trim();
                  userEmail = credential.email ?? '';
                }
                setState((){
                  loginPlatform = 'Apple';
                  loginStatus = 'logged in';
                });
              },
          ),
          ),

                 /*  setState(() {
                    userName = auth.user!.displayName;
                    userEmail = auth.user!.email;
                    loginPlatform = 'apple';
                  });
                  print('-------apple credential--------$auth');
                },*/
          //),
              //),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SignInButton(
                  Buttons.Microsoft,
                  mini: false,
                  onPressed: () async {
                    try {
                      final Map<String, dynamic> userInfo = await signInWithMicrosoft();
                      setState(() {
                        userName = userInfo['displayName'];
                        userEmail = userInfo['mail'];
                        loginPlatform = 'Microsoft';
                        loginStatus = 'logged in';
                      });
                    } catch(e) {
                      print(e);
                    }

                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextButton(
                    onPressed: () {
                      //final user = FirebaseAuth.instance.currentUser;
                      //FirebaseAuth.instance.signOut();
                      GoogleSignInApi.logout();
                      setState(() {
                        userName = null;
                        userEmail = null;
                        loginPlatform = null;
                        loginStatus = 'not log in';
                      });
                    },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                    child: const Text('Logout',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                        ),),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Text('Login platform: $loginPlatform\nUser: $userName\nEmail: $userEmail\nLogin status:$loginStatus',
                    style: const TextStyle(
                        fontSize: 25,
                    ),
                    ),
                  ],
                ),
              )
            ]
          ),
        ),
      ),
    );
  }
}