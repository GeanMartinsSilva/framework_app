import 'package:flutter/material.dart';
import 'package:framework_app/app/views/home_page.dart';
import 'package:framework_app/app/widgets/loginField_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginController = TextEditingController();
  final senhaController = TextEditingController();

  void checkLogin() {
    if (loginController.text == '123@123.com' &&
        senhaController.text == '123123') {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Framework App'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            loginField('Login', 'digite 123@123.com', loginController),
            loginField('Senha', 'digite 123123', senhaController),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: RaisedButton(
                color: Color(0xff7900DF),
                onPressed: () {
                  checkLogin();
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'FAÇA O LOGIN',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
