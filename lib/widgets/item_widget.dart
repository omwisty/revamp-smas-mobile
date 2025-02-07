import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartfren_attendance/widgets/snackbar_widget.dart';

enum ItemWidgetType {
  left,
  justify
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    Key? key,
    required this.label,
    required this.value,
    required this.itemType
  }) : super(key: key);

  final String label;
  final String value;
  final ItemWidgetType itemType;

  @override
  Widget build(BuildContext context) {
    switch (itemType) {
      case ItemWidgetType.left:
        return Container(
          width: MediaQuery.of(context).size.width,
          padding: label == "UUID" ? const EdgeInsets.only(left: 10) : const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
          margin: const EdgeInsets.only(top: 8, left: 16, right: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 15.0)
            ]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              label == "UUID" ?
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "$label : $value",
                      overflow: TextOverflow.fade,
                      softWrap: false
                    )
                  ),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      primary: Colors.black54,
                    ),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: value));
                      SnackBarWidget(title: "Info", message: "UUID copied!", type: SnackBarType.info).show();
                    },
                    icon: const Icon(Icons.copy, size: 20),
                    label: const Text("Copy")
                  ),
                ],
              ) : Text("$label : $value")
            ],
          )
        );
      case ItemWidgetType.justify:
        return Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
          margin: const EdgeInsets.only(top: 8, left: 16, right: 16),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 15.0)
              ]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Text(
                  label,
                  overflow: TextOverflow.fade,
                  softWrap: false
                )
              ),
              Expanded(
                child: Text(
                  value,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ),
            ],
          )
        );
    }
  }

}