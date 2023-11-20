import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/font.dart';

class ListTileDrawer extends StatelessWidget {
  final Widget map;
  final String imagedata;
  final String textdata;
  const ListTileDrawer(
      {super.key,
      required this.imagedata,
      required this.textdata,
      required this.map});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(imagedata),
      title: Text(
        textdata,
        style: readexPro(),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => map));
      },
    );
  }
}
