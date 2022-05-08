import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:ski_slope/base/bloc_listener.dart';
import 'package:ski_slope/pages/login/login_bloc.dart';
import 'package:ski_slope/pages/main_screen.dart';
import 'package:ski_slope/resources/colors.dart';
import 'package:ski_slope/resources/dimensions.dart';
import 'package:ski_slope/utilities/extensions.dart';
import 'package:ski_slope/utilities/navigation.dart';
import 'package:ski_slope/utilities/snackbar_viewer.dart';
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
  final SnackBarViewer _snackBarViewer = BlocProvider.getDependency();
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
                      textInputAction: TextInputAction.next,
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
                      textInputAction: TextInputAction.done,
                      onEditingComplete: _validateAndLogin,
                    ),
                    const SizedBox(height: Dimensions.loginSpacer),
                    Consumer<LoginBloc>(
                      builder: (context, bloc) => ConditionalBuilder(
                        condition: (_bloc.state is! LoadingState),
                        positiveBuilder: (context) => Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SkiButton(
                              onPressed: _validateAndLogin,
                              child: Text(context.text.login),
                            ),
                            const SizedBox(height: Dimensions.loginSpacer / 3),
                            SkiButton(
                              onPressed: () async {
                                bool isConnected = await _bloc.isConnected();
                                if (isConnected) {
                                  navigateToPage(
                                    context,
                                    builder: (context) => SkiWebPage(
                                      appBarTitle: context.text.loginWithGooglePage,
                                      isGoogleAuth: true,
                                      userAgent: Platform.isIOS
                                          ? 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_1_2 like Mac OS X) AppleWebKit/605.1.15'
                                              ' (KHTML, like Gecko) Version/13.0.1 Mobile/15E148 Safari/604.1'
                                          : 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) '
                                              'AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36',
                                      onPageFinished: (url) {
                                        _bloc.loginWithGoogle(url);
                                      },
                                      url:
                                          "https://projekt-pp-tab-2022.herokuapp.com/oauth2/authorize/google?redirect_uri=https://projekt-pp-tab-2022.herokuapp.com/api/auth/test/everyone",
                                    ),
                                  );
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset("assets/login_screen/googleLogo.png", scale: 21),
                                  const SizedBox(width: Dimensions.loginSpacer / 3),
                                  Text(context.text.loginWithGoogle),
                                ],
                              ),
                            ),
                            const Divider(height: Dimensions.loginSpacer / 3),
                            SkiButton(
                              style: ElevatedButton.styleFrom(
                                  primary: SkiColors.additionalColor, onPrimary: SkiColors.mainColor),
                              onPressed: () => navigateToPage(
                                context,
                                builder: (context) => const SkiWebPage(
                                  //TODO change url to register site
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

  void _validateAndLogin() {
    if (_formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      _bloc.login();
    }
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
      _snackBarViewer.showSnackBar(context, context.text.incorrectLoginData);
    } else if (state is NoInternetState) {
      _snackBarViewer.showSnackBar(context, context.text.noInternetConnection);
    } else if (state is ServerFailState) {
      _snackBarViewer.showSnackBar(context, context.text.loginServerFail);
    }
  }
}
