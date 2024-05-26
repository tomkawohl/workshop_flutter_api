import 'package:flutter/material.dart';
import 'package:what_do_i_like/api/api.dart';
import 'package:what_do_i_like/ui/screens/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Connexion")),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Nom d\'utilisateur',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un nom d\'utilisateur';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Mot de passe',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre mot de passe';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _login();
                  }
                },
                child: const Text('Se connecter'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _login() async {
    var data = {
      'username': _usernameController.text,
      'password': _passwordController.text,
    };

    try {
      final response = await ApiClient().postRequest(
        '/login',
        data,
      );

      if (response.statusCode == 200) {
        ApiClient().token = response.data['token'];
        ApiClient().userId = response.data['id'];
        if (mounted) {
          _showMessage('Connexion réussie', Colors.green);
        }
        if (mounted) Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      } else {
        if (mounted) {
          _showMessage('Nom d\'utilisateur ou mot de passe incorrect', Colors.red);
        }
      }
    } catch (e) {
      if (mounted) {
        _showMessage('Erreur de connexion', Colors.red);
      }
      print('Error connexion: $e');
    }
  }

  void _showMessage(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
