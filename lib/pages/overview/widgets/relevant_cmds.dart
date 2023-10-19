
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web/constants/style.dart';
import 'package:flutter_web/services/api.dart';
import 'package:flutter_web/widgets/custom_text.dart';

import 'package:flutter_web/models/commande.dart';
import 'package:flutter_web/widgets/heading_text.dart';

class RelevantCmds extends StatefulWidget {
  const RelevantCmds({super.key});

  @override
  State<RelevantCmds> createState() => _RelevantCmdsState();
}

class _RelevantCmdsState extends State<RelevantCmds> {
  late List<Commande> cmdList;
  var isLoaded = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
      cmdList = await ApiService().fetchCommands();
      if(cmdList != null){
        setState(() {
          isLoaded = true;
        });
      }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: active.withOpacity(.4), width: .5),
        boxShadow: [BoxShadow(offset: const Offset(0, 6), color: lightGrey.withOpacity(.1), blurRadius: 12)],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Row(
            children: [
              SizedBox(
                width: 10,
              ),
              CustomText(
                text: "Commandes en cours de préparation",
                color: lightGrey,
                weight: FontWeight.bold,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Visibility(
              visible: isLoaded,
              replacement: const Center(child: CircularProgressIndicator()),
              child: SizedBox(
                height: (56 * 7) + 40,
                child: (isLoaded)?DataTable2(
                  columnSpacing: 12,
                  dataRowHeight: 56,
                  headingRowHeight: 40,
                  horizontalMargin: 12,
                  minWidth: 600,
                  columns: const [
                    DataColumn2(
                      label: HeadingText(text: "Numéro de piece"),
                      size: ColumnSize.L,
                    ),
                    DataColumn(
                      label: HeadingText(text: 'Client'),
                    ),
                    DataColumn(
                      label: HeadingText(text: 'Etat'),
                    ),
                    DataColumn(
                      label: HeadingText(text: 'Date'),
                    ),
                    DataColumn(
                      label: HeadingText(text: 'Action'),
                    ),
                  ],
                  rows: generateDataRows(cmdList),
                ):const CustomText(text: 'problem serveur'),
              ),)
        ],
      ),
    );
  }

  unlockCmd(Commande cmd) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: light,
          title: Text(
            "Confirmation",
            style: TextStyle(color: Colors.black54),
          ),
          content: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              "Voulez-vous vraiment verrouiller la commande : ${cmd.numpiece} ?",
              style: TextStyle(
                color: dark,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: ()  {
                updateCmd(cmd);
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0), // Ajout du padding
                child: Text(
                  "oui",
                  style: TextStyle(color: Colors.white), // Couleur du texte du bouton
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
              backgroundColor: light,
              ),
              child:  Padding(
                padding: const EdgeInsets.all(8.0), // Ajout du padding
                child: Text(
                  "non",
                  style: TextStyle(color: dark), // Couleur du texte du bouton
                ),
              ),
            ),
          ],
        );
      },
    );
  }


  List<DataRow> generateDataRows(List<Commande> commandeList) {
    return commandeList.map((commande) {
      return DataRow(
        cells: [
          DataCell(CustomText(text: commande.numpiece)),
          DataCell(CustomText(text: commande.client)),
          DataCell(CustomText(text: commande.etat)),
          DataCell(CustomText(text: commande.date)),
          DataCell(
              Visibility(
                visible: commande.ver,
                child: IconButton(
                    icon: const Icon(Icons.lock_open_outlined, color: active),
                    onPressed: () => unlockCommande(commande)),

              )
          ),
        ],
      );
    }).toList();
  }

  unlockCommande(Commande commande) {
    unlockCmd(commande);
  }

  void updateCmd(Commande cmd) async {
    Commande updatedCmd = await ApiService().unlockCommande(cmd);
    setState(() {
      cmd.ver = updatedCmd.ver;
      getData();
    });

  }

}





