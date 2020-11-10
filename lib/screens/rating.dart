import 'package:fake_reviews/models/items_provider.dart';
import 'package:fake_reviews/models/log_recipient.dart';
import 'package:fake_reviews/screens/description.dart';
import 'package:fake_reviews/screens/instruction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../gesture_logger.dart';

class Rating extends StatefulWidget {
  Rating({Key key, this.item}) : super(key: key);

  final String item;

  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> {
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
              context.read<LogRecipient>().addRenderedEvent(
                  ViewRenderedEvent(item: widget.item, view: 'Rating'))
            },
          firstTime = false
        });

    List<DragTarget> stars = [];
    for (var i = 1; i <= 5; i++)
      stars.add(DragTarget(
        builder: (context, List candidateData, rejectedData) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              i <= elementSelected
                  ? Icons.star_rounded
                  : Icons.star_border_rounded,
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
        onAccept: (data) {
          context.read<LogRecipient>().addReview(
              ReviewEvent(stars: elementSelected, item: widget.item));

          var builder;
          if (this.widget.item == 'prova1') {
            builder = (context) => Description(item: 'prova2');
          } else if (this.widget.item == 'prova2') {
            // cosa faccio finita la prova?
            var item = context.read<ItemsProvider>();
            var next = item.getOne();
            builder = (context) => Description(item: next);
          }
          if (builder == null) {
            var item = context.read<ItemsProvider>();
            var next = item.getOne();
            if (next != null) {
              builder = (context) => Description(item: next);
            } else {
              builder = (context) => Instruction(index: messages.length - 1);
            }
          }
          Navigator.push(
            context,
            CupertinoPageRoute(builder: builder),
          );
        },
      ));

    return WillPopScope(
      onWillPop: () async => false,
      child: GestureLogger(
        child: Scaffold(
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            margin: MediaQuery.of(context).padding,
            child: Column(children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
                child: Image.asset('images/Prodotto_${widget.item}.jpg'),
              ),
              Expanded(
                  child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: stars,
                    ),
                  ),
                  Positioned(
                    bottom: 32,
                    // right: 0,
                    child: Draggable(
                      child: Icon(
                        Icons.edit,
                        size: 40,
                      ),
                      feedback: Icon(
                        Icons.edit,
                        size: 40,
                      ),
                    ),
                  ),
                ],
              )),
            ]),
          ),
        ),
      ),
    );
  }
}
