import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirstInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Text(
            'Innanzitutto grazie per partecipare all\'esperimento.\nOra ti verranno chiesta alcune semplici domande su di te pe conoscere chi fa il test'),
        bottomNavigationBar: Container(
          width: double.infinity,
          child: TextButton(
            child: new Text(
              "Avanti",
            ),
            onPressed: () {
              // Navigator.push(
              // context,
              // MaterialPageRoute(
              // builder: (context) => RatingScreen(item: this.item)),
              // );
            },
          ),
        ),
      ),
    );
  }
}