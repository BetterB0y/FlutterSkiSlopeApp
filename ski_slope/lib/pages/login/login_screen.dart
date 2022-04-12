import 'package:flutter/material.dart';
import 'package:ski_slope/pages/main_screen.dart';
import 'package:ski_slope/resources/colors.dart';
import 'package:ski_slope/resources/dimensions.dart';
import 'package:ski_slope/utilities/extensions.dart';
import 'package:ski_slope/utilities/navigation.dart';
import 'package:ski_slope/utilities/validation.dart';
import 'package:ski_slope/widgets/ski_app_bar.dart';
import 'package:ski_slope/widgets/ski_button.dart';
import 'package:ski_slope/widgets/ski_web_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    const inputDecoration = InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: SkiColors.mainColor, width: 2.0),
      ),
    );

    return Scaffold(
      appBar: SkiAppBar(title: context.text.loginTitle),
      body: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingLarge),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                enableSuggestions: true,
                keyboardType: TextInputType.name,
                autocorrect: false,
                decoration: inputDecoration.copyWith(
                  labelText: context.text.username,
                ),
                cursorColor: SkiColors.mainColor,
                validator: (value) => value?.isUserNameValid ?? false ? null : context.text.loginUsernameIncorrect,
              ),
              const SizedBox(height: Dimensions.loginSpacer),
              TextFormField(
                obscureText: !_passwordVisible,
                enableSuggestions: false,
                autocorrect: false,
                decoration: inputDecoration.copyWith(
                  labelText: context.text.password,
                  suffixIcon: IconButton(
                    icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
                    color: SkiColors.mainColor,
                    onPressed: () => setState(() => _passwordVisible = !_passwordVisible),
                  ),
                ),
                cursorColor: SkiColors.mainColor,
                validator: (value) => value?.isPasswordValid ?? false ? null : context.text.loginPasswordTooShort,
              ),
              const SizedBox(height: Dimensions.loginSpacer),
              SkiButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) _navigateToMainScreen(context);
                },
                child: Text(context.text.login),
              ),
              const SizedBox(height: Dimensions.loginSpacer / 3),
              SkiButton(
                style: ElevatedButton.styleFrom(primary: SkiColors.additionalColor, onPrimary: SkiColors.mainColor),
                onPressed: () => navigateToPage(
                  context,
                  builder: (context) => const SkiWebPage(
                    url: "https://www.google.com",
                  ),
                ),
                child: Text(context.text.register),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToMainScreen(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const MainScreen(),
        ),
        (_) => false);
  }
}
