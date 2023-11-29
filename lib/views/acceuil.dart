import 'package:flutter/material.dart';
import 'package:vehicules/views/register.dart';
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          // Image de fond
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/acceuil.jpg'),
                fit: BoxFit.cover, // Ajuste l'image pour remplir la boîte, en recadrant si nécessaire.
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken), // Applique un filtre de fondu sombre (ajustez l'opacité selon vos besoins).
              ),
            ),
          ),
          // Contenu au-dessus de l'image
          Padding(
            padding: EdgeInsets.only(top: 500), // Ajustez la valeur en fonction de votre préférence
            child: Center(
              child: Text(
                'Etes vous prets?',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 600), // Ajustez la valeur en fonction de votre préférence
            child: Center(
              child: Text(
                'Faites nous confiances en choisisant les plus belles voitures',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
            ),
          ),
          // Bouton en bas de l'image
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) =>  RegisterPage ()),
                  );

                  // Action à effectuer  lorsque le bouton est pressé.
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple, // Couleur de fond du bouton
                  onPrimary: Colors.white, // Couleur du texte du bouton
                ),
                child: Text('commencer'),
              ),
            ),
          )

        ],
      ),
    );
  }
}
