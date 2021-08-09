import 'package:courses_example_project/src/common/modals/app_error_modal.dart';
import 'package:courses_example_project/src/common/widgets/custom_button.dart';
import 'package:courses_example_project/src/common/widgets/custom_navigation_bar.dart';
import 'package:courses_example_project/src/common/widgets/custom_text_field.dart';
import 'package:courses_example_project/src/common/widgets/text_field_divider.dart';
import 'package:courses_example_project/src/constants/color_const.dart';
import 'package:courses_example_project/src/constants/padding_const.dart';
import 'package:courses_example_project/src/routes/routing_const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/log_in_bloc.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Dio dio = Dio();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CustomNavigationBar(
        leading: null,
        title: 'Авторизация',
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: AppColors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomTextField(
                  controller: emailController,
                  placeholder: 'Логин или почта',
                ),
                TextFieldDivider(),
                CustomTextField(
                  controller: passwordController,
                  placeholder: 'Пароль',
                  obscureText: true,
                ),
              ],
            ),
          ),
          SizedBox(height: 32),
          Padding(
            padding: AppPaddings.horizontal,
            child: BlocConsumer<LogInBloc, LogInState>(
              listener: (context, state) {
                if (state is LogInLoaded) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    MainRoute,
                    (route) => false,
                  );
                } else if (state is LogInFailed) {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) {
                      return AppErrorModal(
                        message: state.message,
                      );
                    },
                  );
                }
              },
              builder: (context, state) {
                return CustomButton(
                  title: 'Войти',
                  onPressed: state is LogInLoading
                      ? null
                      : () {
                          context.read<LogInBloc>().add(
                                LogInPressed(
                                  email: emailController.text,
                                  password: passwordController.text,
                                ),
                              );
                        },
                );
              },
            ),
          ),
          SizedBox(height: 19),
          Padding(
            padding: AppPaddings.horizontal,
            child: CustomButton(
              title: 'Зарегистрироваться',
              onPressed: () {
                Navigator.pushNamed(context, RegisterRoute);
              },
            ),
          ),
        ],
      ),
    );
  }
}
