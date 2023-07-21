import 'package:appoint_medic/core/color_constants.dart';
import 'package:appoint_medic/core/text_constants.dart';
import 'package:appoint_medic/presentation/login/screen_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ScreenCreateAccountSuccess extends StatelessWidget {
  const ScreenCreateAccountSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: backgroundDecoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              //color: Colors.white.withOpacity(0.5),
              height: size.height * 0.4,
              width: size.width * 0.8,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10)),

              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      'assets/email.png',
                      width: 50,
                      height: 50,
                    ),
                    Text(
                      'Verify your email',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      textVerificationMessage2,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      textVerificationMessage,
                      style: TextStyle(fontSize: 16),
                    ),
                    Spacer(),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => ScreenLogin(),), (route) => false);
                    //   },
                    //   child: Text('back to login'),
                    //   style: ButtonStyle(
                    //     minimumSize:
                    //         MaterialStateProperty.all<Size>(Size(50, 30)),
                    //   ),
                    // )

                    TextButton(onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => ScreenLogin(),), (route) => false);
                      
                    }, child: Text('Back to login'))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
