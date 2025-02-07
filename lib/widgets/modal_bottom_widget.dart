import 'package:flutter/material.dart';

class ModalBottomWidget {
  ModalBottomWidget({
    Key? key,
    required this.context,
    required this.title,
    required this.description,
    this.content = const [],
  });

  final BuildContext context;
  final String title;
  final String description;
  final List<Widget> content;

  show() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          color: Colors.transparent,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0, // has the effect of softening the shadow
                  spreadRadius: 0.0, // has the effect of extending the shadow
                )
              ],
            ),
            alignment: Alignment.topLeft,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 5, left: 16),
                        child: Text(
                          title,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                              color: Colors.black87
                          ),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 5, right: 16),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Close",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          )
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
                    child: Text(description, textAlign: TextAlign.left, style: TextStyle(fontStyle: FontStyle.italic)),
                  ),
                  Column(
                    children: content,
                  )
                ],
              )
            ),
          ),
        );
      }
    );
  }
}