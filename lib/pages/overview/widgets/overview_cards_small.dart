import 'package:flutter/material.dart';
import 'package:flutter_web/pages/overview/widgets/info_card_small.dart';

class OverviewCardsSmallScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Container(
      height: 400,
      child: Column(
        children: [
          InfoCardSmall(
            title: "En attentes",
            value: "7",
            onTap: () {},
            isActive: true,
          ),
          SizedBox(height: _width / 64),
          InfoCardSmall(
            title: "Livrées",
            value: "17",
            onTap: () {},
          ),
          SizedBox(height: _width / 64),
          InfoCardSmall(
            title: "Annulée",
            value: "3",
            onTap: () {},
          ),
          SizedBox(height: _width / 64),
          InfoCardSmall(
            title: "En cours de préparation",
            value: "3",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}