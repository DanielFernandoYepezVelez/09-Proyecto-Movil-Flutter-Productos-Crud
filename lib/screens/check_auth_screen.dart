import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/* Services */
import 'package:productos_app/services/services.dart';

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
              return Text('Espere');
            }

            if (snapshot.data == '') {}

            /* Se Ejecuta Después De La Construcción Del Widget */
            Future.microtask(
              () {
                Navigator.pushReplacementNamed(context, 'home');
              },
            );

            return Container();
          },
        ),
      ),
    );
  }
}
