import 'package:flutter/material.dart';
import 'package:flutter_web/constants/style.dart';
import 'package:flutter_web/widgets/custom_text.dart';

import 'bar_chart.dart';
import 'revenue_info.dart';

class RevenueSectionSmall extends StatelessWidget {
  const RevenueSectionSmall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      margin: EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 6),
                color: lightGrey.withOpacity(.1),
                blurRadius: 12),
          ],
          border: Border.all(color: lightGrey, width: .5)),
      child: Column(
        children: [
          Container(
            height: 260,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomText(
                  text: "livraison / semaine",
                  size: 20,
                  weight: FontWeight.bold,
                  color: lightGrey,
                ),
                Container(
                  width: 600,
                  height: 200,
                  child: SimpleBarChart.withSampleData(),
                ),
              ],
            ),
          ),
          Container(
            width: 120,
            height: 1,
            color: lightGrey,
          ),

          Container(
            height: 260,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    RevenueInfo(
                      title: "Aujourd'hui",
                      amount: "2",
                    ),
                    RevenueInfo(
                      title: "Les 7 derniers jours",
                      amount: "28",
                    ),
                  ],
                ),

                SizedBox(height: 30,),

                Row(
                  children: [
                    RevenueInfo(
                      title: "Les 30 derniers jours",
                      amount: "116",
                    ),
                    RevenueInfo(
                      title: "Les 3 derniers mois",
                      amount: "426",
                    ),
                  ],
                ),
              ],
            ),
          )


        ],
      ),
    );
  }
}