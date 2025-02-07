import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartfren_attendance/pages/profile/controller/profile_controller.dart';
import 'package:smartfren_attendance/widgets/button_widget.dart';
import 'package:smartfren_attendance/widgets/item_widget.dart';

class ProfileView extends StatelessWidget {
  ProfileView({Key? key}) : super(key: key);
  ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: CircleAvatar(
                backgroundColor: Colors.black12,
                child: Image.asset("assets/images/user.png"),
                radius: 50,
              ),
            ),
            Obx(() => ItemWidget(label: "Name", value: controller.name.value, itemType: ItemWidgetType.justify)),
            Obx(() => ItemWidget(
                label: "NIK",
                value: controller.nik.value,
                itemType: ItemWidgetType.justify)),
            const ItemWidget(label: "Email", value: "-", itemType: ItemWidgetType.justify),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 8, left: 16, right: 16),
              child: ButtonWidget(
                onTap: () async {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Info'),
                      content: const Text('Are you sure to SIGN OUT this application?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'NO'),
                          child: const Text('NO'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, 'YES');
                            controller.onSubmitSignOut();
                          },
                          child: const Text('YES'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Center(
                  child: Text("SIGN OUT",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      letterSpacing: 1.0
                    )
                  ),
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}
