import 'package:fake_reviews/providers/items_provider.dart';
import 'package:fake_reviews/providers/log_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../gesture_logger.dart';
import '4_test_description_screen.dart';
import '6_start_experiment.dart';

class TestRatingScreen extends StatefulWidget {
  TestRatingScreen({Key key, this.item}) : super(key: key);

  final Item item;

  @override
  _TestRatingScreenState createState() => _TestRatingScreenState();
}

class _TestRatingScreenState extends State<TestRatingScreen> {
  int elementSelected = -1;
  bool firstTime = true;

  final double starPadding = 8.0;
  final double starSize = 44;

  String state = 'init';

  void setElementSelected(index) {
    setState(() {
      elementSelected = index;
    });
  }

  void showAnimationIn5Seconds() {
    Future.delayed(const Duration(milliseconds: 5000)).then((value) {
      setState(() {
        state = 'animationInProgress';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final int targetAnswer = 4;
    final double oneStarSize = starSize + 2 * starPadding;

    final double startAnimationLeft = MediaQuery.of(context).size.width / 2 - 2 * oneStarSize - 22;
    final double endAnimationLeft = startAnimationLeft + (widget.item.expectedAnswer - 1) * oneStarSize + 1;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(firstTime) {
          context.read<LogProvider>().addRenderedEvent(ViewRenderedEvent(item: widget.item.name, view: 'Rating'));

          setState(() {
            firstTime = false;
          });

          Future.delayed(const Duration(milliseconds: 2000)).then((value) {
            setState(() {
              state = 'animationInProgress';
            });
          });
      }
    });

    List<DragTarget> stars = [];
    for (var i = 1; i <= 5; i++)
      stars.add(DragTarget(
        builder: (context, List candidateData, rejectedData) {
          if (i == 1) {
            return Draggable(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: starPadding),
                child: Icon(
                  i <= elementSelected
                      ? Icons.star_rounded
                      : Icons.star_border_rounded,
                  size: starSize,
                  //color: Colors.yellow,
                ),
              ),
              feedback: Container(),
            );
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: starPadding),
            child: Icon(
              i <= elementSelected
                  ? Icons.star_rounded
                  : Icons.star_border_rounded,
              // color: Colors.yellow,
              size: starSize,
            ),
          );
        },
        onWillAccept: (data) {
          return true;
        },
        onMove: (DragTargetDetails _) {
          setState(() {
            elementSelected = i;
          });
        },
        onLeave: (_) {
          setState(() {
            elementSelected = -1;
          });
        },
        onAccept: (data) {
          context.read<LogProvider>().addReview(
              ReviewEvent(stars: elementSelected, item: widget.item.name));

          var builder;
          var item = context.read<ItemsProvider>();
          var next = item.getOneTest();
          if (next != null) {
            builder = (context) => TestDescriptionScreen(item: next);
          } else {
            builder = (context) => StartExperiment();
          }
          Navigator.push(
            context,
            MaterialPageRoute(builder: builder),
          );
        },
      ));

    final title = Positioned(
      top: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Text(
          widget.item.question,
          style: Theme.of(context).textTheme.headline5,
          textAlign: TextAlign.center,
          maxLines: 2,
          softWrap: true,
        ),
      ),
    );


    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            alignment: Alignment.center,
              fit: StackFit.passthrough,
              children: [
                title,
                Positioned.fill(
                  top: 160,
                  bottom: 160,
                  child: Center(
                      child: Card(
                        child: Image.asset(
                          'images/${widget.item.name}',
                          fit: BoxFit.scaleDown,
                        ),
                      )
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: GestureLogger(
                    child: Container(
                      height: 160,
                      width: 360,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: stars,
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  bottom: 42,
                  left: state != 'animationInProgress' ? startAnimationLeft : endAnimationLeft,
                  onEnd: () {
                    setState(() {
                      state = 'animationFinished';
                      showAnimationIn5Seconds();
                    });
                  },
                  child: state == 'animationInProgress'
                    ? Icon(Icons.touch_app, size: starSize + 4)
                      : Container(),
                    duration: Duration(milliseconds: 2000))
              ]),
        ),
      ),
    );
  }
}
