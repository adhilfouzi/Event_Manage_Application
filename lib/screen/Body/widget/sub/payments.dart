import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/Core/Color/font.dart';

class Payments extends StatelessWidget {
  // final Widget goto;
  const Payments({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Payments', style: raleway()),
              // IconButton(
              //   icon: const Icon(Icons.add_circle_outline_sharp,
              //       color: buttoncolor),
              //   onPressed: () {
              //     Navigator.of(context)
              //         .push(MaterialPageRoute(builder: (context) => goto));
              //   },
              // )
            ],
          ),
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: buttoncolor, width: 1),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/UI/icons/nodata.png',
                      height: 70, width: 70),
                  const SizedBox(height: 10),
                  Text(
                    'No Payments Found',
                    style: raleway(fontSize: 13, color: Colors.black),
                  )
                ]),
          ),
        ],
      ),
    );
  }
}
