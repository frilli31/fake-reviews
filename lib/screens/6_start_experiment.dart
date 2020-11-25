import 'package:fake_reviews/components/bottom_button.dart';
import 'package:fake_reviews/providers/items_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
                    Container(
                        padding: EdgeInsets.only(top: 10),
                        width: double
                            .infinity // used to force the column to expand to full width
                        ),
                    Text(
                      'Ora avrà inizio l\'esperimento',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
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
              ),
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