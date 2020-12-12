import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pencil_reviews/components/bottom_button.dart';
import 'package:pencil_reviews/providers/items_provider.dart';
import 'package:pencil_reviews/screens/4_test_description_screen.dart';
import 'package:pencil_reviews/utils/instruction.dart';
import 'package:provider/provider.dart';

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
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Container(
            constraints: BoxConstraints.expand(),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: instructions.map((instruction) {
                      int index = instructions.indexOf(instruction);
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(index),
                        child: Container(
                            width: 16.0,
                            height: 16.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 8.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _current == index
                                  ? Color.fromRGBO(0, 0, 0, 0.9)
                                  : Color.fromRGBO(0, 0, 0, 0.4),
                            )),
                      );
                    }).toList(),
                  ),
                  CarouselSlider(
                    items: instructions
                        .map((item) => Card(
                              child: SingleChildScrollView(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 4),
                                  child: Container(
                                      constraints: BoxConstraints(
                                        minHeight: height - 182,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ConstrainedBox(
                                            constraints: BoxConstraints(
                                              maxWidth: 150,
                                              maxHeight: 150,
                                            ),
                                            child: Image.asset(
                                              'images/${item.image}',
                                              fit: BoxFit.scaleDown,
                                            ),
                                          ),
                                          Text(
                                            item.text,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                            textAlign: TextAlign.center,
                                            softWrap: true,
                                          ),
                                        ],
                                      ))),
                            ))
                        .toList(),
                    carouselController: _controller,
                    options: CarouselOptions(
                        height: height - 160,
                        enableInfiniteScroll: false,
                        enlargeCenterPage: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                  ),
                  BottomButton(
                    text: _current < instructions.length - 1
                        ? "Avanti"
                        : "Vai alle prove",
                    onPressed: () {
                      if (_current < instructions.length - 1) {
                        _controller.animateToPage(_current + 1);
                      } else {
                        var item = context.read<ItemsProvider>().getOneTest();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TestDescriptionScreen(item: item)),
                        );
                      }
                    },
                  ),
                ])),
      ),
    );
  }
}
