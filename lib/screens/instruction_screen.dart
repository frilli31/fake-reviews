import 'package:carousel_slider/carousel_slider.dart';
import 'package:fake_reviews/gesture_logger.dart';
import 'package:fake_reviews/providers/items_provider.dart';
import 'package:fake_reviews/providers/log_provider.dart';
import 'package:fake_reviews/screens/test_description_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'description_screen.dart';

const messages = [
  'Dovrai ora immaginare di acquistare dei prodotti o dei servizi.\n\nIl tuo compito sarà quello di recensire ciascuno dei prodotti e servizi acquistati.',
  'In alcuni casi la situazione d’acquisto ti chiederà di valutare il prodotto/servizio soltanto sulla base della sua qualità.\n\nIn altri casi dovrai invece tenere conto anche di altri elementi, che potranno influenzare in positivo o in negativo la tua recensione, spingendoti a fornire una valutazione non genuina del prodotto/servizio.',
  'Ti verranno ora presentati alcuni esempi di prodotti/servizi da valutare.',
  'Valuta, sulla base dell’esperienza descritta, quanto sei soddisfatto di ciascun prodotto/servizio.\n\nTrascina la penna fino alle stelle per attribuire la valutazione. Oppure fai tap sulla prima stella a sinistra e trascina fino alla valutazione desiderata',
  'Valuta il prodotto/servizio su una scala da 1 (per niente soddisfatto) a 5 (pienamente soddisfatto), tenendo conto di tutti gli elementi che possono influenzare la tua valutazione.',
];

class InstructionScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Instruction();
  }
}

class _Instruction extends State<InstructionScreen> {
  final CarouselController _controller = CarouselController();
  int _current = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Container(
            constraints: BoxConstraints.expand(),
            child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: messages.map((url) {
                      int index = messages.indexOf(url);
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(index),
                        child: Container(
                            width: 8.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _current == index
                                  ? Color.fromRGBO(0, 0, 0, 0.9)
                                  : Color.fromRGBO(0, 0, 0, 0.4),
                            )),
                      );
                    }).toList(),
                  ),
                  Positioned.fill(
                    child: Center(
                      child:  CarouselSlider(
                        items: instructionCards,
                        carouselController: _controller,
                        options: CarouselOptions(
                            enableInfiniteScroll: false,
                            enlargeCenterPage: true,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                              });
                            }),
                      ),
                    )
                  ),
                ]),
          ),
          bottomNavigationBar: Container(
            width: double.infinity,
            child: TextButton(
              child: new Text(
                _current < messages.length -1
                    ? "Avanti"
                    : "Fai una prova",
              ),
              onPressed: () {
                if(_current < messages.length -1) {
                  _controller.animateToPage(_current + 1);
                } else {
                  var item = context.read<ItemsProvider>().getOneTest();

                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => TestDescriptionScreen(item: item)),
                  );
                }
              },
            ),
          ),
        )
    );
  }
}

final List<Widget> instructionCards = messages
    .map((item) =>
    Container(
      margin: EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
              child: Text(item)
          ),
        ),
      ),
    ))
    .toList();

