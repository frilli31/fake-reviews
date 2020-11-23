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
          body: Column(children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Complimenti!',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    'Ora avrà inizio l\'esperimento',
                    style: Theme.of(context).textTheme.bodyText2,
                  )
                ],
              ),
            )
          ]),
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