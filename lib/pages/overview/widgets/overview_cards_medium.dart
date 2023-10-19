import 'package:flutter/material.dart';
import 'package:flutter_web/constants/style.dart';

import 'info_card.dart';

class OverviewCardsMediumScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            InfoCard(
              title: "En attentes",
              value: "7",
              onTap: () {},
              topColor: Colors.orange,
            ),
            SizedBox(
              width: _width / 64,
            ),
            InfoCard(
              title: "Livrées",
              value: "17",
              onTap: () {},
              topColor: Colors.lightGreen,
            ),

          ],
        ),

        SizedBox(height: 16),

        Row(
          children: [
            InfoCard(
              title: "Annulée",
              value: "3",
              onTap: () {},
              topColor: Colors.redAccent,
            ),
            SizedBox(
              width: _width / 64,
            ),
            InfoCard(
              title: "En cours de préparation",
              value: "3",
              onTap: () {},
            ),
          ],
        )
      ],

    );
  }
}