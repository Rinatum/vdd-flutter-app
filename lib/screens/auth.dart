import 'package:cpmdwithf_project/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cpmdwithf_project/domain/user.dart';

class AuthorizationPage extends StatefulWidget {
  const AuthorizationPage({Key? key}) : super(key: key);

  @override
  AuthorizationPageState createState() => AuthorizationPageState();
}

class AuthorizationPageState extends State<AuthorizationPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late String _email;
  late String _password;
  bool showLogin = true;

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    Widget logo() {
      return const Padding(
          padding: EdgeInsets.only(top: 100),
          child: Align(
            child: Text("Damage Detection",
                style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ));
    }

    Widget input(Icon icon, String hint, TextEditingController controller,
        bool obsecure) {
      return Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          controller: controller,
          obscureText: obsecure,
          style: const TextStyle(fontSize: 20, color: Colors.white),
          decoration: InputDecoration(
              hintStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white30),
              hintText: hint,
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 3)),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white54, width: 1)),
              prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: IconTheme(
                    data: const IconThemeData(color: Colors.white),
                    child: icon,
                  ))),
        ),
      );
    }

    Widget button(String text, void Function() func) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.red,
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
          minimumSize: const Size(100, 40), //////// HERE
        ),
        onPressed: () {
          func();
        },
        child: Text(text),
      );
    }

    Widget form(String label, void Function() func) {
      return Column(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 10),
              child: input(
                  const Icon(Icons.email), "EMAIL", emailController, false)),
          Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: input(const Icon(Icons.lock), "PASSWORD",
                  passwordController, true)),
          const SizedBox(
            height: 20,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: button(label, func)))
        ],
      );
    }

    void loginButtonAction() async {
      _email = emailController.text;
      _password = passwordController.text;

      if (_email.isEmpty || _password.isEmpty) return;

      UserOur? user = await _authService.signInWithEmailAndPassword(
          _email.trim(), _password.trim());
      if (user == null) {
        Fluttertoast.showToast(
            msg: "Cant sign in :( . Check email",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        emailController.clear();
        passwordController.clear();
      }
    }

    void registerButtonAction() async {
      _email = emailController.text;
      _password = passwordController.text;

      if (_email.isEmpty || _password.isEmpty) return;

      UserOur? user = await _authService.registerInWithEmailAndPassword(
          _email.trim(), _password.trim());
      if (user == null) {
        Fluttertoast.showToast(
            msg: "Cant Register  :( . Check email/password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        emailController.clear();
        passwordController.clear();
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: <Widget>[
          logo(),
          (showLogin
              ? Column(
                  children: <Widget>[
                    form("Login", loginButtonAction),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                          child:
                              const Text("Not registered yet ? Register now !"),
                          onTap: () {
                            setState(() {
                              showLogin = false;
                            });
                          }),
                    )
                  ],
                )
              : Column(
                  children: <Widget>[
                    form("Register", registerButtonAction),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                          child: const Text("Already registered yet ? Login!"),
                          onTap: () {
                            setState(() {
                              showLogin = true;
                            });
                          }),
                    )
                  ],
                ))
        ],
      ),
    );
  }
}
