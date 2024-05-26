import 'package:flutter/material.dart';
import 'package:what_do_i_like/ui/screens/login.dart';
import 'package:what_do_i_like/ui/screens/register.dart';
import 'package:what_do_i_like/ui/widget/customSizedBox.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const H(20),
                Center(
                  child: Image.asset(
                    'assets/images/logo_text.png',
                    width: 300,
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () => _register(context),
                  child: const Text("S'inscrire"),
                ),
                const H(8),
                ElevatedButton(
                  onPressed: () => _signIn(context),
                  child: const Text('Se connecter'),
                ),
                const H(40),
              ],
            ),
          ),
        ),
      );

  static void _register(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen()));
  }

  static void _signIn(BuildContext context) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
}
