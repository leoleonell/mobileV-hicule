import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isLoading = false;
  bool isPasswordVisible = false;

  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  void registerUser() async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(''); // Remplacez par votre URL d'API

    final response = await http.post(
      url,
      body: {
        'nom': nomController.text,
        'prenom': prenomController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'password_confirmation': confirmPasswordController.text,
      },
    );

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userToken', data['token']);

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Succès'),
            content: Text(data['message']),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Fermer'),
              ),
            ],
          );
        },
      );
    } else {
      final data = json.decode(response.body);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Erreur'),
            content: Text(data['message']),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Fermer'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Inscription",
          style: GoogleFonts.abhayaLibre(
            color: Colors.black,
            fontWeight: FontWeight.w900,
            fontSize: 24,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.7,
              child: Lottie.asset("assets/images/lf20_pprxh53t.json"),
            ),
            TextFormField(
              controller: nomController,
              decoration: InputDecoration(labelText: 'Nom'),
            ),
            TextFormField(
              controller: prenomController,
              decoration: InputDecoration(labelText: 'Prénom'),
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'E-mail'),
            ),
            TextFormField(
              controller: passwordController,
              obscureText: !isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Mot de passe',
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: togglePasswordVisibility,
                ),
              ),
            ),
            TextFormField(
              controller: confirmPasswordController,
              obscureText: !isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Confirmez le mot de passe',
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: togglePasswordVisibility,
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: isLoading ? null : () {
                registerUser();
              },
              child: Text(isLoading ? 'En cours...' : "S'inscrire"),
            ),
          ],
        ),
      ),
    );
  }
}

