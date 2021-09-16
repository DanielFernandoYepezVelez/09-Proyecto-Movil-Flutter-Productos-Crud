import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/* Services */
import 'package:productos_app/services/services.dart';

/* Login Screen */
import 'package:productos_app/screens/screens.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.readToken(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (!snapshot.hasData) {
              return Text('');
            }

            if (snapshot.data == '') {
              /* Se Ejecuta Después De La Construcción Del Widget */
              Future.microtask(
                () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => LoginScreen(),
                      transitionDuration: Duration(seconds: 0),
                    ),
                  );

                  // Navigator.pushReplacementNamed(context, 'home');
                },
              );
            } else {
              /* Se Ejecuta Después De La Construcción Del Widget */
              Future.microtask(
                () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => HomeScreen(),
                      transitionDuration: Duration(seconds: 0),
                    ),
                  );

                  // Navigator.pushReplacementNamed(context, 'home');
                },
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
