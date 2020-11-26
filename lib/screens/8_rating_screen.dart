import 'package:fake_reviews/providers/items_provider.dart';
import 'package:fake_reviews/providers/log_provider.dart';
import 'package:fake_reviews/screens/7_description_screen.dart';
import 'package:fake_reviews/screens/9_conclusion_screeen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../gesture_logger.dart';

class RatingScreen extends StatefulWidget {
  RatingScreen({Key key, this.item}) : super(key: key);

  final Item item;

  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  int elementSelected = -1;
  bool firstTime = true;

  void setElementSelected(index) {
    setState(() {
      elementSelected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => {
          if (firstTime)
            {
              context.read<LogProvider>().addRenderedEvent(
                  ViewRenderedEvent(item: widget.item.name, view: 'Rating'))
            },
          firstTime = false
        });

    List<DragTarget> stars = [];
    for (var i = 1; i <= 5; i++)
      stars.add(DragTarget(
        builder: (context, List candidateData, rejectedData) {
          if (i == 1) {
            return Draggable(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  i <= elementSelected
                      ? Icons.star_rounded
                      : Icons.star_border_rounded,
                  size: 44,
                  //color: Colors.yellow,
                ),
              ),
              feedback: Container(),
            );
          }
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              i <= elementSelected
                  ? Icons.star_rounded
                  : Icons.star_border_rounded,
              // color: Colors.yellow,
              size: 40,
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
          var next = item.getOne();
          if (next != null) {
            builder = (context) => DescriptionScreen(item: next);
          } else {
            builder = (context) => ConclusionScreen();
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
                        padding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
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
                                maxHeight: MediaQuery
                                    .of(context)
                                    .size
                                    .height - 320,
                              ),
                              child: Card(
                                child: Image.asset(
                                  'images/${widget.item.name}',
                                  fit: BoxFit.scaleDown,
                                ),
                              )
                          )
                      )
                    ],
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
              ]),
        ),
      ),
    );
  }
}
