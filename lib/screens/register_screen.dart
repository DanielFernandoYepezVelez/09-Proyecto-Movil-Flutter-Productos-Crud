import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/* Services */
import 'package:flutter_productos_crud/services/services.dart';

/* Provider */
import 'package:flutter_productos_crud/providers/login_form_provider.dart';

/* Widgets */
import 'package:flutter_productos_crud/widgets/widgets.dart';

/* UI InputDecorations */
import 'package:flutter_productos_crud/ui/input_decoration.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  NativeAd? _nativeVideoAd;
  bool _isLoadedVideoNative = false;

  @override
  void initState() {
    super.initState();
    _loadVideoNativeAd();
  }

  void _loadVideoNativeAd() {
    _nativeVideoAd = NativeAd(
      // adUnitId: 'ca-app-pub-3940256099942544/1044960115',
      adUnitId: 'ca-app-pub-2118916369098036/3995506557',
      factoryId: 'listTile',
      request: const AdRequest(),
      listener: NativeAdListener(onAdLoaded: (ad) {
        /* print('Video Ad Loaded Successfully'); */
        setState(() {
          _isLoadedVideoNative = true;
        });
      }, onAdFailedToLoad: (ad, error) {
        /* print(
            'Actually Ad Video Failed To Load ${error.message}, ${error.code}'); */
        ad.dispose();
      }),
    );

    _nativeVideoAd!.load();
  }

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
                    Container(
                      height: 300,
                      width: double.infinity,
                      color: Colors.black12,
                      alignment: _isLoadedVideoNative ? null : Alignment.center,
                      child: !_isLoadedVideoNative
                          ? FadeInImage(
                              placeholder: AssetImage('assets/iphy.gif'),
                              image: AssetImage('assets/giphy.gif'),
                            )
                          : AdWidget(ad: _nativeVideoAd!),
                    ),
                    SizedBox(height: 10),
                    Text('Crear Cuenta',
                        style: Theme.of(context).textTheme.headline4),
                    SizedBox(height: 30),

                    /* *** PROVIDER *** Solo Lo Que Exista Dentro Del LoginForm 
                    Va A Tener Acceso Al Provider De LoginFormProvider */
                    ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(),
                      child: _LoginForm(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              TextButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, 'login'),
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(
                    Colors.indigo.withOpacity(0.1),
                  ),
                  shape: MaterialStateProperty.all(StadiumBorder()),
                ),
                child: Text(
                  '¿Ya Tienes Una Cuenta?',
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.loginInputDecoration(
                hintText: 'dani.do@gmail.com',
                labelText: 'Correco Electrónico',
                prefixIcon: Icons.alternate_email_sharp,
              ),
              onChanged: (value) => loginForm.email = value,
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = new RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'El Correo No Es Válido';
              },
            ),
            SizedBox(height: 30),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.loginInputDecoration(
                hintText: '****',
                labelText: 'Contraseña',
                prefixIcon: Icons.lock_outline,
              ),
              onChanged: (value) => loginForm.password = value,
              validator: (value) {
                /* Yo Puedo Retornar Un Null O Un String (Pero Debo Retornar Algo) */
                return (value != null && value.length >= 6)
                    ? null
                    : 'La Contraseña Debe Ser De 6 Carácteres';
              },
            ),
            SizedBox(height: 30),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(loginForm.isLoading ? 'Espere...' : 'Ingresar',
                    style: TextStyle(color: Colors.white)),
              ),
              onPressed: loginForm.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();

                      final authService =
                          Provider.of<AuthService>(context, listen: false);

                      if (!loginForm.isValidForm()) return;

                      loginForm.isLoading = true;

                      /* Validar Si El Login Es Correcto */
                      final String? errorMessage = await authService.createUser(
                          loginForm.email, loginForm.password);

                      // print(errorMessage);

                      if (errorMessage == null) {
                        Navigator.pushReplacementNamed(context, 'home');
                      } else {
                        // print(errorMessage);
                        NotificationsService.showSnackbar(errorMessage);
                        loginForm.isLoading = false;
                      }
                    },
            ),
          ],
        ),
      ),
    );
  }
}
