import 'package:fake_reviews/gesture_logger.dart';
import 'package:fake_reviews/mixins/reporting.dart';
import 'package:fake_reviews/screens/rating.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Description extends StatelessWidget with Reporting {
  Description({Key key, this.item}) : super(key: key);

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String item;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => this.report(context));
    return GestureLogger(
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
                MaterialPageRoute(
                    builder: (context) => Rating(item: this.item)),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return item;
  }
}
