import 'package:fake_reviews/components/bottom_button.dart';
import 'package:fake_reviews/providers/items_provider.dart';
import 'package:fake_reviews/screens/8_rating_screen.dart';
import 'package:fake_reviews/screens/5_test_rating_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
          body: Column(children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Text(
                item.description.first,
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.start,
              ),
            ),
            Expanded(
              child: Center(
                child: Card(
                  child: Image.asset(
                    'images/${item.name}',
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            )
          ]),
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
