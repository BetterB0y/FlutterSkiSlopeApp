import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:ski_slope/base/bloc_listener.dart';
import 'package:ski_slope/pages/register/register_bloc.dart';
import 'package:ski_slope/resources/colors.dart';
import 'package:ski_slope/resources/dimensions.dart';
import 'package:ski_slope/utilities/extensions.dart';
import 'package:ski_slope/utilities/navigation.dart';
import 'package:ski_slope/utilities/snackbar_viewer.dart';
import 'package:ski_slope/utilities/validation.dart';
import 'package:ski_slope/widgets/ski_app_bar.dart';
import 'package:ski_slope/widgets/ski_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final RegisterBloc _bloc = BlocProvider.getBloc();
  final _showSnackBar = SnackBarViewer().showSnackBar;

  bool _firstPasswordInvisible = true;
  bool _secondPasswordInvisible = true;

  @override
  Widget build(BuildContext context) {
    const inputDecoration = InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: SkiColors.mainColor,
          width: Dimensions.inputDecorationWidth,
        ),
      ),
    );

    return Scaffold(
      appBar: SkiAppBar(
        title: context.text.registerAppBarTitle,
      ),
      body: BlocListener<RegisterBloc>(
        onChanged: (state) => _onStateChanged(context, state),
        builder: (context) => Form(
          key: _formKey,
          child: ListView(
            padding:
                const EdgeInsets.symmetric(horizontal: Dimensions.paddingLarge, vertical: Dimensions.paddingBigPlus),
            children: [
              TextFormField(
                onChanged: (text) => _bloc.firstName = text,
                enableSuggestions: true,
                keyboardType: TextInputType.name,
                autocorrect: false,
                decoration: inputDecoration.copyWith(
                  labelText: context.text.firstName,
                ),
                cursorColor: SkiColors.mainColor,
                validator: (value) => value?.isFirstNameValid ?? false ? null : context.text.registerFistNameNotEmpty,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: Dimensions.formSpacer),
              TextFormField(
                onChanged: (text) => _bloc.lastName = text,
                enableSuggestions: true,
                keyboardType: TextInputType.name,
                autocorrect: false,
                decoration: inputDecoration.copyWith(
                  labelText: context.text.lastName,
                ),
                cursorColor: SkiColors.mainColor,
                validator: (value) => value?.isLastNameValid ?? false ? null : context.text.registerLastNameNotEmpty,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: Dimensions.formSpacer),
              TextFormField(
                onChanged: (text) => _bloc.username = text,
                enableSuggestions: true,
                keyboardType: TextInputType.name,
                autocorrect: false,
                decoration: inputDecoration.copyWith(
                  labelText: context.text.username,
                ),
                cursorColor: SkiColors.mainColor,
                validator: (value) => value?.isUserNameValid ?? false ? null : context.text.loginUsernameIncorrect,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: Dimensions.formSpacer),
              TextFormField(
                onChanged: (text) => _bloc.email = text,
                enableSuggestions: true,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                decoration: inputDecoration.copyWith(
                  labelText: context.text.email,
                ),
                cursorColor: SkiColors.mainColor,
                validator: (value) => value?.isEmail ?? false ? null : context.text.registerInvalidEmail,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: Dimensions.formSpacer),
              TextFormField(
                onChanged: (text) => _bloc.password = text,
                obscureText: _firstPasswordInvisible,
                enableSuggestions: false,
                autocorrect: false,
                decoration: inputDecoration.copyWith(
                  labelText: context.text.password,
                  suffixIcon: IconButton(
                    icon: Icon(_firstPasswordInvisible ? Icons.visibility : Icons.visibility_off),
                    color: SkiColors.mainColor,
                    onPressed: () => setState(() => _firstPasswordInvisible = !_firstPasswordInvisible),
                  ),
                ),
                cursorColor: SkiColors.mainColor,
                validator: (value) =>
                    value?.isPasswordValid ?? false ? null : context.text.loginPasswordTooShortTooLong,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: Dimensions.formSpacer),
              TextFormField(
                onChanged: (text) => _bloc.repeatedPassword = text,
                obscureText: _secondPasswordInvisible,
                enableSuggestions: false,
                autocorrect: false,
                decoration: inputDecoration.copyWith(
                  labelText: context.text.repeatPassword,
                  suffixIcon: IconButton(
                    icon: Icon(_secondPasswordInvisible ? Icons.visibility : Icons.visibility_off),
                    color: SkiColors.mainColor,
                    onPressed: () => setState(() => _secondPasswordInvisible = !_secondPasswordInvisible),
                  ),
                ),
                cursorColor: SkiColors.mainColor,
                validator: (value) =>
                    value?.isPasswordValid ?? false ? null : context.text.loginPasswordTooShortTooLong,
                textInputAction: TextInputAction.done,
                onEditingComplete: _validateAndRegister,
              ),
              const SizedBox(height: Dimensions.formSpacer),
              SkiButton(
                onPressed: _validateAndRegister,
                child: Text(context.text.register),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _validateAndRegister() {
    if (_formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      _bloc.validatePasswordAndRegister();
    }
  }

  void _onStateChanged(BuildContext context, RegisterState state) {
    if (state is SuccessState) {
      navigateBack(context);
      _showSnackBar(context, context.text.registered);
    } else if (state is InvalidPasswordState) {
      _showSnackBar(context, context.text.passwordNotIdentical);
    } else if (state is UserExistsState) {
      _showSnackBar(context, context.text.userAlreadyExists);
    } else if (state is NoInternetState) {
      _showSnackBar(context, context.text.noInternetConnection);
    } else if (state is ErrorState) {
      _showSnackBar(context, context.text.registerFail);
    }
  }
}
