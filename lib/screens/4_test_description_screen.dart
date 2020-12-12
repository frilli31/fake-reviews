import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pencil_reviews/components/bottom_button.dart';
import 'package:pencil_reviews/providers/items_provider.dart';
import 'package:pencil_reviews/screens/5_first_test_rating_screen.dart';

class TestDescriptionScreen extends StatelessWidget {
  TestDescriptionScreen({Key key, this.item}) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    final name = item.name.split('.').first;

    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Center(
                  child: Text(
                    item.description[0],
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width,
                    maxHeight: MediaQuery.of(context).size.height - 320,
                  ),
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: Image.asset(
                      'images/${item.name}',
                      fit: BoxFit.scaleDown,
                    ),
                  ))
            ],
          ),
          bottomNavigationBar: BottomButton(
            text: "Avanti",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TestRatingScreen(item: this.item)),
              );
            },
          ),
        ),
      ),
    );
  }
}
