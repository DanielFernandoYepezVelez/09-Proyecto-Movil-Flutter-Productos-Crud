import 'package:flutter/material.dart';

/* Widgets */
import 'package:productos_app/widgets/widgets.dart';

/* UI InputDecorations */
import 'package:productos_app/ui/input_decoration.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 250),
              CardContainer(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Text('Login', style: Theme.of(context).textTheme.headline4),
                    SizedBox(height: 30),
                    _LoginForm(),
                  ],
                ),
              ),
              SizedBox(height: 50),
              Text(
                'Crear Una Nueva Cuenta',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.loginInputDecoration(
                  hintText: 'dani.do@gmail.com',
                  labelText: 'Correco Electrónico',
                  prefixIcon: Icons.alternate_email_sharp),
            ),
            SizedBox(height: 30),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.loginInputDecoration(
                  hintText: '****',
                  labelText: 'Contraseña',
                  prefixIcon: Icons.lock_outline),
            ),
            SizedBox(height: 30),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              disabledColor: Colors.deepPurple,
              elevation: 0,
              // color: Colors.deepPurple,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text('Ingresar', style: TextStyle(color: Colors.white)),
              ),
              onPressed: null,
            ),
          ],
        ),
      ),
    );
  }
}
