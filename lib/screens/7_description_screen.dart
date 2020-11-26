import 'package:fake_reviews/components/bottom_button.dart';
import 'package:fake_reviews/providers/items_provider.dart';
import 'package:fake_reviews/screens/8_rating_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

class DescriptionScreen extends StatefulWidget {
  DescriptionScreen({Key key, this.item}) : super(key: key);

  final Item item;

  @override
  _DescriptionScreenState createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  double heightOfText = 500;

  @override
  Widget build(BuildContext context) {
    final Item item = widget.item;
    final name = item.name.split('.').first;

    final List<Widget> phrases = item.description.map((phrase) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
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
          body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery
                        .of(context)
                        .size
                        .height - heightOfText - 92,
                  ),
                  child: Card(
                    margin: EdgeInsets.all(24),
                    child: Image.asset(
                      'images/${item.name}',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                WidgetSize(
                  onChange: (double height) {
                    setState(() {
                      heightOfText = height;
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Column(
                      children: phrases,
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                ),
              ]),
          bottomNavigationBar: BottomButton(
            text: "Avanti",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RatingScreen(item: item)),
              );
            },
          ),
        ),
      ),
    );
  }
}

class WidgetSize extends StatefulWidget {
  final Widget child;
  final Function onChange;

  const WidgetSize({
    Key key,
    @required this.onChange,
    @required this.child,
  }) : super(key: key);

  @override
  _WidgetSizeState createState() => _WidgetSizeState();
}

class _WidgetSizeState extends State<WidgetSize> {
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
    return Container(
      key: widgetKey,
      child: widget.child,
    );
  }

  var widgetKey = GlobalKey();

  void postFrameCallback(_) {
    var context = widgetKey.currentContext;
    if (context == null) return;

    widget.onChange(context.size.height);
  }
}
