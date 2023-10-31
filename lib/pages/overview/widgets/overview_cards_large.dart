import 'package:flutter/material.dart';
import 'package:flutter_web/constants/style.dart';
import 'package:flutter_web/pages/overview/widgets/info_card.dart';
import 'package:flutter_web/services/api.dart';


class OverviewCardsLargeScreen extends StatefulWidget {
  const OverviewCardsLargeScreen({super.key});

  @override
  State<OverviewCardsLargeScreen> createState() => _OverviewCardsLargeScreenState();
}

class _OverviewCardsLargeScreenState extends State<OverviewCardsLargeScreen> {

  late Future<Map<String, dynamic>> cmdList;
   var isLoaded = false;

   @override
   void initState() {
     getData();
     super.initState();
   }

   getData() async {
     cmdList = ApiService().fetchStats();
   }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return FutureBuilder<Map<String, dynamic>>(
      future: cmdList,
      builder: (
          BuildContext context,
          AsyncSnapshot<Map<String, dynamic>> snapshot,
          ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Text('Error');
          } else if (snapshot.hasData) {
            Map<String, dynamic>? list = snapshot.data ?? {};
            return Row(
              children: [
                InfoCard(
                  title: "Initial",
                  value: list!['initial'].toString(),
                  onTap: () {},
                ),
                SizedBox(
                  width: _width / 64,
                ),
                InfoCard(
                  title: "En preparation",
                  value: list!['en preparation'].toString(),
                  onTap: () {},
                  topColor: Colors.orange,
                ),
                SizedBox(
                  width: _width / 64,
                ),
                InfoCard(
                  title: "Termine",
                  value: list!['termine'].toString(),
                  onTap: () {},
                  topColor: Colors.black54,
                ),

                SizedBox(
                  width: _width / 64,
                ),
                InfoCard(
                  title: "Livree",
                  value: list!['livree'].toString(),
                  onTap: () {},
                  topColor: Colors.green,
                ),
                SizedBox(
                  width: _width / 64,
                ),
                InfoCard(
                  title: "Annule",
                  value: list!['annule'].toString(),
                  onTap: () {},
                  topColor: Colors.redAccent,
                ),

              ],
            );
          } else {
            return const Text('Empty data');
          }
        } else {
          return Text('State: ${snapshot.connectionState}');
        }
      },
    );

  }
}