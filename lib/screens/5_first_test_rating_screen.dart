import 'package:async/async.dart';
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

const double _starPadding = 8.0;
const double _starSize = 44;
final double _oneStarSize = _starSize + 2 * _starPadding;
final double delayBetweenAnimations = 12000;

class _TestRatingScreenState extends State<TestRatingScreen> {
  int elementSelected = -1;
  bool firstTime = true;

  String state = 'init';

  bool hideClueAnimation = false;
  bool textIndicationToggle = false;
  var scheduledAnimation;

  void setElementSelected(index) {
    setState(() {
      elementSelected = index;
    });
  }

  void cancelAnimations() {
    state = 'init';
    scheduledAnimation?.cancel();
  }

  void showAnimationInFuture(delay) {
    cancelAnimations();
    scheduledAnimation = CancelableOperation.fromFuture(
            Future.delayed(Duration(milliseconds: delay)))
        .then((value) {
      setState(() {
        state = 'animationInProgress';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double startAnimationLeft =
        MediaQuery.of(context).size.width / 2 - 2 * _oneStarSize - 22;
    final double endAnimationLeft = startAnimationLeft +
        (widget.item.expectedAnswer - 1) * _oneStarSize +
        1;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (firstTime) {
        context.read<LogProvider>().addRenderedEvent(
            ViewRenderedEvent(item: widget.item.name, view: 'Rating'));

        setState(() {
          firstTime = false;
        });

        var delay = widget.item.name.contains('1') ? 1500 : 8000;

        showAnimationInFuture(delay);
        Future.delayed(Duration(milliseconds: delay + 3200)).then((value) {
          setState(() {
            textIndicationToggle = true;
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
                padding: EdgeInsets.symmetric(horizontal: _starPadding),
                child: Icon(
                  i <= elementSelected
                      ? Icons.star_rounded
                      : Icons.star_border_rounded,
                  size: _starSize,
                  //color: Colors.yellow,
                ),
              ),
              feedback: Container(),
              onDragStarted: () {
                cancelAnimations();
                setState(() {
                  hideClueAnimation = true;
                });
              },
              onDragEnd: (DraggableDetails _) {
                setState(() {
                  hideClueAnimation = false;
                });
                showAnimationInFuture(8000);
              },
            );
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: _starPadding),
            child: Icon(
              i <= elementSelected
                  ? Icons.star_rounded
                  : Icons.star_border_rounded,
              // color: Colors.yellow,
              size: _starSize,
            ),
          );
        },
        onWillAccept: (data) => true,
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
        onAccept: (data) async {
          if (elementSelected != widget.item.expectedAnswer) {
            await showDialog(context: context,
                builder: (_) =>
                    AlertDialog(
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text(
                                  'La risposta che hai selezionato (${elementSelected}) non è corretta',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyText2),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Riprova'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ]
                    )
            );
            setState(() {
              elementSelected = -1;
            });
            return;
          }
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

    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          body: Stack(
              alignment: Alignment.center,
              fit: StackFit.passthrough,
              children: [
                Positioned(
                  top: 0,
                  bottom: 160,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        padding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Center(
                          child: Text(
                            widget.item.question,
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline5,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Flexible(
                          child: Container(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                maxHeight:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .height - 320,
                              ),
                              child: Card(
                                child: Image.asset(
                                  'images/${widget.item.name}',
                                  fit: BoxFit.scaleDown,
                                ),
                              )))
                    ],
                  ),
                ),
                Positioned(
                    bottom: 140,
                    child: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: AnimatedOpacity(
                            duration: Duration(milliseconds: 1000),
                            opacity: textIndicationToggle ? 1 : 0,
                            child: Text(
                              "Trascina la prima stella per lasciare la recensione",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                  color: Colors.black.withOpacity(0.7)),
                              textAlign: TextAlign.center,
                            ),
                            onEnd: () {
                              int delay = textIndicationToggle ? 2500 : 1000;
                              Future.delayed(Duration(milliseconds: delay))
                                  .then((value) {
                                setState(() {
                                  textIndicationToggle = !textIndicationToggle;
                                });
                              });
                            })
                    )
                ),
                AnimatedPositioned(
                    bottom: 42,
                    left: state != 'animationInProgress'
                        ? startAnimationLeft
                        : endAnimationLeft,
                    onEnd: () {
                      setState(() {
                        state = 'animationFinished';
                        showAnimationInFuture(12000);
                      });
                    },
                    child: state == 'animationInProgress' &&
                        hideClueAnimation == false
                        ? Icon(Icons.touch_app, size: _starSize + 4)
                        : Container(),
                    duration: Duration(milliseconds: 2500)),
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
              ]),
        ),
      ),
    );
  }
}
