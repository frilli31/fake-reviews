import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fake_reviews/components/bottom_button.dart';
import 'package:fake_reviews/providers/items_provider.dart';
import 'package:fake_reviews/screens/4_test_description_screen.dart';
import 'package:fake_reviews/utils/instruction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InstructionScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Instruction();
  }
}

class _Instruction extends State<InstructionScreen> {
  final CarouselController _controller = CarouselController();
  final List<ScrollController> _scrollControllers =
      List.generate(instructions.length, (index) => ScrollController());
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.vertical;
    return SafeArea(
      child: Scaffold(
          body: Column(
              mainAxisSize: MainAxisSize.max,
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
                      margin:
                          EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
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
              items: instructions.map((item) {
                int index = instructions.indexOf(item);
                return Card(
                    child: Scrollbar(
                        controller: _scrollControllers[index],
                        isAlwaysShown: true,
                        child: SingleChildScrollView(
                          controller: _scrollControllers[index],
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 4),
                          child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: height - 182,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 150,
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxWidth: 150,
                                        maxHeight: 150,
                                      ),
                                      child: Image.asset(
                                        'images/${item.image}',
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 4),
                                    child: Text(
                                      item.text,
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                      textAlign: TextAlign.center,
                                      softWrap: true,
                                    ),
                                  )
                                ],
                              )),
                        )));
              }).toList(),
              carouselController: _controller,
              options: CarouselOptions(
                  height: height - 150,
                  enableInfiniteScroll: false,
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
    );
  }
}
