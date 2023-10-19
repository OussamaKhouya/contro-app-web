import 'package:flutter/material.dart';
import 'package:flutter_web/constants/style.dart';
import 'package:flutter_web/pages/overview/widgets/bar_chart.dart';
import 'package:flutter_web/pages/overview/widgets/revenue_info.dart';
import 'package:flutter_web/widgets/custom_text.dart';

class RevenueSectionLarge extends StatelessWidget {
  const RevenueSectionLarge({Key? key}) : super(key: key);

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
      child: Row(
        children: [
          Expanded(child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomText(text: "livraison / semaine",
                size: 20, weight: FontWeight.bold, color: lightGrey,),

              Container(
                width: 600,
                height: 200,
                child: SimpleBarChart.withSampleData(),
              )
            ],
          )),

          Container(
            width: 1,
            height: 120,
            color: lightGrey,
          ),

          Expanded(child: Column(
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
          ))
        ],
      ),
    );
  }
}