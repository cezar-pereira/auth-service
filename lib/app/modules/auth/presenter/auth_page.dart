import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:login_service/app/core/components/snackbar_error_custom_component.dart';
import 'package:login_service/app/modules/auth/presenter/components/text_form_field_pass.dart';
import 'package:login_service/app/modules/auth/presenter/components/text_form_field_user.dart';
import 'package:login_service/app/modules/auth/presenter/functions/auth_validations.dart';

import 'auth_store.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends ModularState<AuthPage, AuthStore> {
  var validations = AuthValidations();
  final _formKey = GlobalKey<FormState>();
  bool _loginLoading = false;

  loginLoading() {
    setState(() {
      _loginLoading = !_loginLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 150),
                Text(
                  'Olá.\nBem-vindo',
                  style: Theme.of(context).textTheme.headline3,
                ),
                const SizedBox(height: 60),
                TextFormFieldUserComponent(
                  validation: validations.user,
                  onChanged: (value) {
                    store.controllerUser.text = value;
                  },
                ),
                const SizedBox(height: 30),
                TextFormFieldPassComponent(
                  validation: validations.pass,
                  onChanged: (String value) {
                    store.controllerPassword.text = value;
                  },
                ),
                const SizedBox(height: 80),
                SizedBox(
                  width: double.maxFinite,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _login();
                      }
                    },
                    child: _loginLoading
                        ? const CircularProgressIndicator.adaptive()
                        : const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child: Text('Entrar'),
                          ),
                    style: ButtonStyle(
                        shadowColor: MaterialStateProperty.all(Colors.black87),
                        elevation: MaterialStateProperty.all(10)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login() async {
    loginLoading();
    var result = await store.login();
    result.fold((l) {
      loginLoading();
      SnackBarErrorCustom(context: context, error: l.errorMessage).call();
    }, (r) => Modular.to.pushReplacementNamed('/home/'));
  }
}
