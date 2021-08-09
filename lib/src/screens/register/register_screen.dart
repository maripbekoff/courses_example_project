import 'package:courses_example_project/src/common/modals/app_error_modal.dart';
import 'package:courses_example_project/src/common/widgets/custom_button.dart';
import 'package:courses_example_project/src/common/widgets/custom_navigation_bar.dart';
import 'package:courses_example_project/src/common/widgets/custom_text_field.dart';
import 'package:courses_example_project/src/common/widgets/text_field_divider.dart';
import 'package:courses_example_project/src/routes/routing_const.dart';
import 'package:courses_example_project/src/screens/register/bloc/register_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CustomNavigationBar(title: 'Регистрация'),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 32),
            Container(
              color: CupertinoColors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTextField(
                    controller: loginController,
                    placeholder: 'Логин',
                  ),
                  TextFieldDivider(),
                  CustomTextField(
                    controller: phoneController,
                    placeholder: 'Телефон',
                  ),
                  TextFieldDivider(),
                  CustomTextField(
                    controller: emailController,
                    placeholder: 'Почта',
                  ),
                  TextFieldDivider(),
                  CustomTextField(
                    controller: passwordController,
                    placeholder: 'Пароль',
                    obscureText: obscureText,
                    suffix: CupertinoButton(
                      child: Icon(
                        CupertinoIcons.eye_slash,
                        color: CupertinoColors.black,
                      ),
                      onPressed: () =>
                          setState(() => obscureText = !obscureText),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BlocConsumer<RegisterBloc, RegisterState>(
                listener: (context, state) {
                  if (state is RegisterFailed) {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) => AppErrorModal(
                        message: 'Не удалось войти',
                      ),
                    );
                  } else if (state is RegisterLoaded) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      MainRoute,
                      (route) => false,
                    );
                  }
                },
                builder: (context, state) {
                  return CustomButton(
                    title: 'Создать аккаунт',
                    onPressed: () => context.read<RegisterBloc>().add(
                          Register(
                            email: emailController.text,
                            nickname: loginController.text,
                            phone: phoneController.text,
                            password: passwordController.text,
                          ),
                        ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
