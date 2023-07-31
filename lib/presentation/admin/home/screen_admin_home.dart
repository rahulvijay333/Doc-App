import 'package:appoint_medic/application/login/login_bloc.dart';
import 'package:appoint_medic/domain/db/db_model.dart';
import 'package:appoint_medic/presentation/login/screen_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenAdminHomePage extends StatelessWidget {
  const ScreenAdminHomePage({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin '),
        centerTitle: true,
        actions: [
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state is LogoutLoading) {
                //snackbar

                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Logging out...')));
                });
              } else if (state is LogoutSucess) {
                
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) {
                      return ScreenLogin();
                    },
                  ));
                });
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              }

              return IconButton(
                  onPressed: () {
                    BlocProvider.of<LoginBloc>(context)
                        .add(LogOutButtonClicked('admin'));
                  },
                  icon: const Icon(Icons.logout));
            },
          )
        ],
      ),
      body: const Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('Admin page')]),
      ),
    );
  }
}
