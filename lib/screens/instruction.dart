import 'package:fake_reviews/gesture_logger.dart';
import 'package:fake_reviews/models/log_recipient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'description.dart';

const messages = [
  'Benvenuto!',
  'Dovrai ora immaginare di acquistare dei prodotti o dei servizi.\n\nIl tuo compito sarà quello di recensire ciascuno dei prodotti e servizi acquistati.',
  'In alcuni casi la situazione d’acquisto ti chiederà di valutare il prodotto/servizio soltanto sulla base della sua qualità.\n\nIn altri casi dovrai invece tenere conto anche di altri elementi, che potranno influenzare in positivo o in negativo la tua recensione, spingendoti a fornire una valutazione non genuina del prodotto/servizio.',
  'Ti verranno ora presentati alcuni esempi di prodotti/servizi da valutare.',
  'Valuta, sulla base dell’esperienza descritta, quanto sei soddisfatto di ciascun prodotto/servizio. Trascina la penna fino alle stelle per attribuire la valutazione.',
  'Valuta il prodotto/servizio su una scala da 1 (per niente soddisfatto) a 5 (pienamente soddisfatto), tenendo conto di tutti gli elementi che possono influenzare la tua valutazione.',
  'L’esperimento è concluso, grazie per la collaborazione.',
];

class Instruction extends StatelessWidget {
  Instruction({
    Key key,
    this.index = 0,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => context
        .read<LogRecipient>()
        .addRenderedEvent(
            ViewRenderedEvent(item: index.toString(), view: '$runtimeType')));
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureLogger(
        child: Scaffold(
          body: Container(
            margin: MediaQuery.of(context).padding,
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Text(
              messages[index],
            )),
          ),
          bottomNavigationBar: Container(
            width: double.infinity,
            child: RaisedButton(
              child: new Text(
                "Avanti",
              ),
              onPressed: this.index == (messages.length - 1)
                  ? null
                  : () {
                      var builder;

                      if (this.index < (messages.length - 2)) {
                        builder =
                            (context) => Instruction(index: this.index + 1);
                      } else if (this.index == (messages.length - 2)) {
                        builder = (context) => Description(item: 'prova1');
                        final mediaQuery = MediaQuery.of(context);
                        context
                            .read<LogRecipient>()
                            .sendScreenDetails(ScreenDetails(
                              width: mediaQuery.size.width,
                              height: mediaQuery.size.height,
                              details: mediaQuery.toString(),
                            ));
                      }

                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: builder),
                      );
                    },
            ),
          ),
        ),
      ),
    );
  }
}
