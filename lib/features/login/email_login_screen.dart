import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:malf/shared/logger.dart';
import 'package:malf/shared/network/token.dart';
import 'package:malf/shared/usecases/loading.dart';

class EmailLoginScreen extends StatefulWidget {
  @override
  _EmailLoginScreenState createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('email_login'.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if ((value ?? "").isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!(value ?? "").contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
                validator: (value) {
                  if ((value ?? "").isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              FloatingActionButton(
                child: Text('login'.tr()),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    loading(context);
                    try {
                      Response response = await Dio().post(
                          "https://malftravel.com/auth/local/login",
                          data: {
                            "email": _emailController.text,
                            "password": _passwordController.text
                          });
                      logger.d(response.data);
                      if (response.statusCode == 200) {
                        Token().setToken(response.data['token']['refreshToken'],
                            response.data['token']['accessToken']);
                        context
                          ..pop()
                          ..go('/home');
                        return;
                      }
                    } on Exception catch (e) {
                      // TODO
                      logger.e(e);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Login failed'),
                        ),
                      );
                    }
                    context.pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
