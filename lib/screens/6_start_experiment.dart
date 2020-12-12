import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pencil_reviews/components/bottom_button.dart';
import 'package:pencil_reviews/providers/items_provider.dart';
import 'package:provider/provider.dart';

import '7_description_screen.dart';

class StartExperiment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Complimenti!',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Text(
                      'Ora avrà inizio l\'esperimento',
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 200,
                        maxHeight: 200,
                      ),
                      child: Image.asset(
                        'images/start_experiment.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  )),
            ],
          ),
          bottomNavigationBar: BottomButton(
            text: "Avanti",
            onPressed: () {
              var item = context.read<ItemsProvider>().getOne();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DescriptionScreen(item: item)),
              );
            },
          ),
        ),
      ),
    );
  }
}
