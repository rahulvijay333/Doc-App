import 'package:appoint_medic/application/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:appoint_medic/core/color_constants.dart';
import 'package:appoint_medic/presentation/login/widget/enter_email.dart';
import 'package:appoint_medic/presentation/login/widget/new_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenChangePasswordDoctor extends StatelessWidget {
  ScreenChangePasswordDoctor(
      {super.key, required this.userType, required this.title});
  final String userType;

  final _passFormkey = GlobalKey<FormState>();
  final _emailFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final String title;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: WillPopScope(
          onWillPop: () async {
            warningMessage(context);

            return false;
          },
          child: Column(
            children: [
              //--------------------------------------app bar
              Container(
                width: size.width,
                height: size.height * 0.07,
                color: appBackGround,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          //------------------------------pop function
                          // Navigator.of(context).pop();

                          warningMessage(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        )),
                        Text('Change password',style: TextStyle(fontSize: 20,color: Colors.white),)
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                    builder: (context, state) {
                      if (state is ForgotPasswordInitial) {
                        return const Center(
                          child: Text('Forgot password'),
                        );
                      } else if (state is ForgotPasswordEnterEmail) {
                        return EnterEmailWidget(
                            size: size,
                            emailKey: _emailFormKey,
                            typeUser: userType,
                            emailAddressController: emailController,
                            title: title);
                      } else if (state is ResetEmailError) {
                        WidgetsBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.all(15),
                              content: Text(state.error)));
                        });
                        return EnterEmailWidget(
                            size: size,
                            emailKey: _emailFormKey,
                            typeUser: userType,
                            emailAddressController: emailController,
                            title: title);
                      } else if (state is EmailCheckingLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                          ),
                        );
                      } else if (state is ForgotPasswordEnterPasswords) {
                        return EnterNewPasswordWidget(
                          size: size,
                          passkey: _passFormkey,
                          typeUser: state.userType,
                          email: state.email,
                          token: state.token,
                          confirmPasswordController: confirmPasswordController,
                          newPasswordController: newPasswordController,
                        );
                      } else if (state is NewPasswordLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                          ),
                        );
                      } else if (state is PasswordChangeSuccess) {
                        //--------------------------------------------------success
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: size.width * 0.3,
                              child: Image.asset(
                                  'assets/password_change_success.gif'),
                            ),
                            Text(
                              'Account password changed',
                              style: TextStyle(
                                  fontSize: size.width * 0.06,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: size.height * 0.2,
                            ),
                            SizedBox(
                              height: 40,
                              width: size.width * 0.3,
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();

                                    context
                                        .read<ForgotPasswordBloc>()
                                        .add(ClearForgotPasswordState());
                                  },
                                  child: const Text('Done')),
                            )
                          ],
                        );
                      } else if (state is PasswordChangeFailed) {
                        //----------------------------------------password failed
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: size.width * 0.3,
                              child: Image.asset(
                                  'assets/password_reset_failed.gif'),
                            ),
                            Text(
                              'Password reset failed',
                              style: TextStyle(
                                  fontSize: size.width * 0.06,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: size.height * 0.2,
                              child: Center(child: Text(state.error)),
                            ),
                            SizedBox(
                              height: 40,
                              width: size.width * 0.3,
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();

                                    context
                                        .read<ForgotPasswordBloc>()
                                        .add(ClearForgotPasswordState());
                                  },
                                  child: const Text('Exit')),
                            )
                          ],
                        );
                      }

                      return const SizedBox();
                    },
                  ),
                ),
              )

              //--------------------------------------
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> warningMessage(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Attention'),
          content: const Text('Do you want to cancel ?'),
          actions: [
            TextButton(
                onPressed: () {
                  //------------------

                  Navigator.of(context).pop();
                },
                child: const Text('No')),
            TextButton(
                onPressed: () {
                  //------------------

                  Navigator.of(context).pop();

                  Navigator.of(context).pop();
                  context
                      .read<ForgotPasswordBloc>()
                      .add(ClearForgotPasswordState());
                },
                child: const Text('Yes'))
          ],
        );
      },
    );
  }
}
