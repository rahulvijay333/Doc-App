import 'package:appoint_medic/application/login/login_bloc.dart';
import 'package:appoint_medic/presentation/login/screen_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenAdminNotVerified extends StatelessWidget {
  const ScreenAdminNotVerified({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
                height: size.height * 0.07,
                color: Colors.blue,
                width: size.width,
                child: const Center(
                  child: Text(
                    'DocCure',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                )),
            Expanded(
                child: Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  
                  children: [
                  Text('Admin has not verified your account yet'),
                  SizedBox(
                    height: 15,
                  ),
                  TextButton.icon(
                      onPressed: () {
                        //-----------------------------------------back to login page
    
                        context.read<LoginBloc>().add(ClearLoginStateEvent());
    
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) {
                            return ScreenLogin();
                          },
                        ));
                      },
                      icon: Icon(Icons.logout),
                      label: Text('Back to login'))
                ]),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
