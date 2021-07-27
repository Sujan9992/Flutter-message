import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final bool isLoading;
  final void Function(
    String email,
    String user,
    String password,
    bool isLogin,
    BuildContext context,
  ) submit;

  const AuthForm({required this.submit, required this.isLoading});

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  bool _isLogin = true;
  String _email = '';
  String _user = '';
  String _password = '';

  void _trySubmit() {
    final _isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (_isValid) {
      _formKey.currentState!.save();
      widget.submit(
          _email.trim(), _user.trim(), _password.trim(), _isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Theme.of(context).primaryColor,
        margin: EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    key: ValueKey('email'),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Invalid Email Address';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'Email Address'),
                    style: TextStyle(fontSize: 20.0),
                    onSaved: (value) {
                      _email = value!;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('user'),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 4) {
                          return 'Username must be more than 4 characters.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Username'),
                      style: TextStyle(fontSize: 20.0),
                      onSaved: (value) {
                        _user = value!;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 7) {
                        return 'Password must be 8 character long.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Password'),
                    style: TextStyle(fontSize: 20.0),
                    onSaved: (value) {
                      _password = value!;
                    },
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    TextButton(
                      onPressed: _trySubmit,
                      child: Text(
                        _isLogin ? 'Login' : 'Signup',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  if (!widget.isLoading)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(
                        _isLogin
                            ? 'Create a new account?'
                            : 'I already have an account.',
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
