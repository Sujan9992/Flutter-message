import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:message_flutter/widget/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  void _submitAuthForm(
    String email,
    String user,
    String password,
    bool isLogin,
    BuildContext context,
  ) async {
    var authResult;
    try {
      setState(() {
        _isLoading = true;
      });

      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
      }
      await FirebaseFirestore.instance
          .collection('users')
          .doc(authResult.user.uid)
          .set({'user': user, 'email': email});
      setState(() {
        _isLoading = false;
      });
    } on PlatformException catch (error) {
      var message = 'Please recheck your credentials.';
      if (error.message != null) {
        message = error.message!;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print('Error Found');
      print(err);
      _isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        submit: _submitAuthForm,
        isLoading: _isLoading,
      ),
    );
  }
}
