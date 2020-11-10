import 'package:fake_reviews/gesture_logger.dart';
import 'package:fake_reviews/models/log_recipient.dart';
import 'package:fake_reviews/screens/rating.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Description extends StatelessWidget {
  Description({Key key, this.item}) : super(key: key);

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String item;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => context
        .read<LogRecipient>()
        .addRenderedEvent(ViewRenderedEvent(item: item, view: '$runtimeType')));
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureLogger(
        child: Scaffold(
          body: Center(
            child: Image.asset('images/Descriz_${this.item}.jpg'),
          ),
          bottomNavigationBar: Container(
            width: double.infinity,
            child: RaisedButton(
              child: new Text(
                "Avanti",
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => Rating(item: this.item)),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
