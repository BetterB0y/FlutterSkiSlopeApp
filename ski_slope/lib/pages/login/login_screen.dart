import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:ski_slope/base/bloc_listener.dart';
import 'package:ski_slope/pages/login/login_bloc.dart';
import 'package:ski_slope/pages/main_screen.dart';
import 'package:ski_slope/resources/colors.dart';
import 'package:ski_slope/resources/dimensions.dart';
import 'package:ski_slope/utilities/extensions.dart';
import 'package:ski_slope/utilities/navigation.dart';
import 'package:ski_slope/utilities/snackbar.dart';
import 'package:ski_slope/utilities/validation.dart';
import 'package:ski_slope/widgets/conditional_builder.dart';
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
  final LoginBloc _bloc = BlocProvider.getBloc();
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SkiAppBar(title: context.text.loginTitle),
      body: Builder(
        builder: (builderContext) => BlocListener<LoginBloc>(
          onChanged: (state) => onStateChanged(builderContext, state),
          builder: (context) {
            const inputDecoration = InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: SkiColors.mainColor, width: 2.0),
              ),
            );

            return Padding(
              padding: const EdgeInsets.all(Dimensions.paddingLarge),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      onChanged: (text) => _bloc.username = text,
                      enableSuggestions: true,
                      keyboardType: TextInputType.name,
                      autocorrect: false,
                      decoration: inputDecoration.copyWith(
                        labelText: context.text.username,
                      ),
                      cursorColor: SkiColors.mainColor,
                      validator: (value) =>
                          value?.isUserNameValid ?? false ? null : context.text.loginUsernameIncorrect,
                    ),
                    const SizedBox(height: Dimensions.loginSpacer),
                    TextFormField(
                      onChanged: (text) => _bloc.password = text,
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
                    ConditionalBuilder(
                      condition: (_bloc.state is! LoadingState),
                      positiveBuilder: (context) => Wrap(
                        direction: Axis.vertical,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          SkiButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) _bloc.login();
                            },
                            child: Text(context.text.login),
                          ),
                          const SizedBox(height: Dimensions.loginSpacer / 3),
                          SkiButton(
                            style: ElevatedButton.styleFrom(
                                primary: SkiColors.additionalColor, onPrimary: SkiColors.mainColor),
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
                      negativeBuilder: (context) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
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

  void onStateChanged(BuildContext context, LoginState state) {
    if (state is SuccessState) {
      _navigateToMainScreen(context);
    } else if (state is IncorrectDataState) {
      showSnackBar(context, context.text.incorrectLoginData);
    } else if (state is NoInternetState) {
      showSnackBar(context, context.text.noInternetConnection);
    }
  }
}
