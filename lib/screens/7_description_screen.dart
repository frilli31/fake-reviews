import 'package:fake_reviews/components/bottom_button.dart';
import 'package:fake_reviews/providers/items_provider.dart';
import 'package:fake_reviews/screens/8_rating_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DescriptionScreen extends StatelessWidget {
  DescriptionScreen({Key key, this.item}) : super(key: key);

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final Item item;

  @override
  Widget build(BuildContext context) {
    final name = item.name.split('.').first;

    final List<Widget> phrases = item.description.map((phrase) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Text(
          phrase,
          style: Theme.of(context).textTheme.bodyText1,
          textAlign: TextAlign.start,
        ),
      );
    }).toList();

    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          body: Column(children: [
            Expanded(
              child: Center(
                child: Card(
                  child: Image.asset(
                    'images/${item.name}',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Column(
                children: phrases,
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            )
          ]),
          bottomNavigationBar: BottomButton(
            text: "Avanti",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RatingScreen(item: this.item)),
              );
            },
          ),
        ),
      ),
    );
  }
}
