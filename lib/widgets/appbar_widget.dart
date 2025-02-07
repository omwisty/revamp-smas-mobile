import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({Key? key,
    required this.preferredSize,
    required this.title,
    this.haveBack = false,
  }) : super(key: key);

  @override
  final Size preferredSize;
  final String title;
  final bool haveBack;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: haveBack ? IconButton(
        icon: const Icon(Icons.arrow_back, color: Color(0xff285A47)),
        onPressed: () => Get.back(),
      ) : Container(),
      leadingWidth: haveBack ? 56 : 0.0,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        title,
        style: const TextStyle(color: Color(0xFF000000)),
      ),
    );
  }

}