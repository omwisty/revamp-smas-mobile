import 'package:flutter/material.dart';

class ComingSoonView extends StatelessWidget {
  const ComingSoonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          right: 0.0,
          top: 0.0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            child: Container(
              alignment: const Alignment(1, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 60),
                    child: Image.asset("assets/images/coming-soon.png", width: 200),
                  ),
                  Image.asset("assets/images/smarty.png", width: 100)
                ],
              )
            )  ,
          )
        ),
      ],
    );
  }

}