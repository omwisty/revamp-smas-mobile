import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartfren_attendance/pages/force_update/controller/force_update_controller.dart';
import 'package:smartfren_attendance/widgets/button_widget.dart';

class ForceUpdateView extends StatelessWidget {
  ForceUpdateView({Key? key}) : super(key: key);
  var controller = Get.put(ForceUpdateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 30.0, right: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/play_store_512.png", width: 70),
                  const SizedBox(height: 5),
                  const Text("SMAS", style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold
                  )),
                  const SizedBox(height: 30),
                  Obx(() => Text("Application Need Update To Version ${controller.newVersion}")),
                  ButtonWidget(
                    onTap: () async {
                      controller.downloadLinkUpdate();
                    },
                    child: const Center(
                      child: Text("Download Now",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            letterSpacing: 1.0
                        )
                      ),
                    )
                  )
                ],
              ),
            )
          ],
        )
      ),
    );
  }

}