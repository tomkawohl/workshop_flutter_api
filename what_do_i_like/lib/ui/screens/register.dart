import 'package:flutter/material.dart';
import 'package:what_do_i_like/api/api.dart';
import 'package:what_do_i_like/ui/widget/customSizedBox.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('S\'inscrire'),
      ),
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
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un nom d\'utilisateur';
                  }
                  return null;
                },
              ),
              const H(20),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Mot de passe',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un mot de passe';
                  }
                  return null;
                },
              ),
              const H(20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _registerUser();
                  }
                },
                child: const Text('S\'inscrire'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _registerUser() async {
    var data = {
      'username': _usernameController.text,
      'password': _passwordController.text,
    };

    try {
      var response = await ApiClient().postRequest('/register', data);
      print('Inscription réussie : ${response.data}');
      if (response.statusCode == 201)
        _showSnackBar('Inscription réussi', true);
      else if (response.statusCode == 400)
        _showSnackBar('Nom d\'utilisateur déjà utilisé', false);
      else
        _showSnackBar('Erreur lors de l\'inscription', false);
    } catch (e) {
      print('Error inscription: $e');
      _showSnackBar('Erreur lors de l\'inscription', false);
    }
    if (mounted) Navigator.pop(context);
  }

  void _showSnackBar(String message, bool isSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: isSuccess ? Colors.green : Colors.red,
      duration: const Duration(seconds: 3),
    ));

    if (isSuccess) {
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          Navigator.pop(context);
        }
      });
    }
  }
}
