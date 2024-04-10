import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_app/common/color_extension.dart';
import 'package:health_app/data/models/user_model.dart';
import 'package:health_app/services/database_service.dart';
import 'package:sign_in_button/sign_in_button.dart';

class Google_sign_in extends StatefulWidget {
  const Google_sign_in({super.key});

  @override
  State<Google_sign_in> createState() => _Google_sign_inState();
}

class _Google_sign_inState extends State<Google_sign_in> {
  // google sign in
  final FirebaseAuth _Auth = FirebaseAuth.instance;
  User? _user;
  @override
  void initState() {
    super.initState();
    _Auth.authStateChanges().listen((event) {
      setState(() {
        _user = event;
      });
    });
  }

  Widget _userInfo() {
    return SizedBox();
  }

  void _handleGoogleSignIn() {
    try {
      GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
      _Auth.signInWithProvider(_googleAuthProvider);
    } catch (error) {
      print(error);
    }
  }
// google sign in finish

// data base access
  final DatabaseService _databaseService = DatabaseService();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Google sign in',
            style: TextStyle(
              color: TColour.black1,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Google sign in',
                style: TextStyle(
                  color: TColour.black1,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SignInButton(
                Buttons.google,
                onPressed: _handleGoogleSignIn,
                text: "Sign with Google",
              ),
              MaterialButton(
                color: Colors.red,
                child: const Text("signout button"),
                onPressed: () {
                  _Auth
                      .signOut(); // Wrap the signOut method call inside a callback function
                },
              ),
              Expanded(
                // Wrap your ListView.builder with an Expanded widget
                child: StreamBuilder(
                  stream: _databaseService.getUsers(),
                  builder: (context, snapshot) {
                    List users = snapshot.data?.docs ?? [];
                    if (users.isEmpty) {
                      return Center(
                        child: Text("add a user"),
                      );
                    }
                    print(users);
                    return ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        UserModel user = users[index].data();
                        print(user);
                        String userId = users[index].id;
                        print(user.email);
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          child: ListTile(
                            title: Text(user.name),
                            subtitle: Text(user.email),
                            trailing: Checkbox(
                                value: user.isPremium,
                                onChanged: (value) {
                                  UserModel updatedUser = user.copyWith(
                                      isPremium: !user.isPremium,
                                      updatedOn: Timestamp.now());
                                  _databaseService.updateUser(
                                      userId, updatedUser);
                                }),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
