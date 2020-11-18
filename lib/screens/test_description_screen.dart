import 'package:fake_reviews/providers/items_provider.dart';
import 'package:fake_reviews/screens/rating_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TestDescriptionScreen extends StatelessWidget {
  TestDescriptionScreen({Key key, this.item}) : super(key: key);

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
            AnimatedContainer(
              duration: Duration(seconds: 3),
              child: Container(
                height: 250,
                width: 150,
                child: Text('Ciao'),
              ),
            ),
            Expanded(
              child: Card(
                margin: EdgeInsets.all(10),
                child: Image.asset(
                  'images/${item.name}',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ]),
          bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: TextButton(
              child: new Text(
                "Avanti",
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => RatingScreen(item: this.item)),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
