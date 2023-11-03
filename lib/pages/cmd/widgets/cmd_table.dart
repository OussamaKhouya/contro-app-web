import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web/constants/constants.dart';
import 'package:flutter_web/constants/controllers.dart';
import 'package:flutter_web/constants/style.dart';
import 'package:flutter_web/controllers/commande_controller.dart';
import 'package:flutter_web/models/cmd.dart';
import 'package:flutter_web/pages/cmd/widgets/custom_dialog.dart';
import 'package:flutter_web/pages/cmd/widgets/cmd_details.dart';
import 'package:flutter_web/routing/routes.dart';
import 'package:flutter_web/services/api.dart';
import 'package:flutter_web/widgets/custom_sel_text.dart';
import 'package:flutter_web/widgets/custom_text.dart';
import 'package:flutter_web/widgets/heading_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../authentication/core/authentication_manager.dart';

class CmdTable extends StatefulWidget {
  final bool showSearchForm;

  const CmdTable({super.key, required bool this.showSearchForm});

  @override
  State<CmdTable> createState() => _RelevantCmdsState();
}

class _RelevantCmdsState extends State<CmdTable> {

  final CommandeController cmdController = Get.put(CommandeController());
  late List<Cmd> cmdList;
  var isLoaded = false;
  String errorMessage = '';
  final _formKey = GlobalKey<FormState>();
  final inputSearch = TextEditingController();
  final transactionDateController = TextEditingController();

  final AuthenticationManager authenticationManager = Get.find();

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    if(widget.showSearchForm){
      cmdList = await ApiService().fetchAllCommands();
    }else{
      cmdList = await ApiService().fetchReleventCommands();
    }
    if (cmdList != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }
  getDataByNupiDate() async {
    cmdList = await ApiService().fetchCmdsByNupiDate(cmdController.selectedNumpiece.value,transactionDateController.text);
    if (cmdList != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility(
            visible: widget.showSearchForm,
            child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: active.withOpacity(.4), width: .5),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 6),
                    color: lightGrey.withOpacity(.1),
                    blurRadius: 12)
              ],
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(16),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 600),
                    padding: const EdgeInsets.all(24),
                    child: Form(
                        key: _formKey,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextFormField(
                                  controller: inputSearch,
                                  decoration: InputDecoration(
                                    labelText: "Numero de piece",
                                    hintText: "K076920949",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      setState(() => errorMessage =
                                      'Entrer un numero de piece valide');
                                      return 'Entrer un numero de piece valide';
                                    }
                                    return null;
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^[a-zA-Z0-9\s.,_-]+$')),
                                  ],
                                  onChanged: (text) =>
                                      setState(() => errorMessage = '')),),
                            SizedBox(width: 20,),
                            Expanded(
                              child: TextFormField(
                                  controller: transactionDateController,
                                  onTap: () {
                                    selectDate(context);
                                  },
                                  decoration: InputDecoration(
                                    labelText: "date",
                                    hintText: "date",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),

                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^[a-zA-Z0-9\s.,_-]+$')),
                                  ],
                                  onChanged: (text) =>
                                      setState(() => errorMessage = '')),),
                            SizedBox(width: 20,),
                            ElevatedButton(
                              onPressed: () {
                                cmdController.selectedNumpiece(inputSearch.text);
                                getDataByNupiDate();
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(20),
                                backgroundColor: active, // Background color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text("Rechercher"),
                            ),
                          ],
                        )
                    ),
                  ),
                ),
              ],
            ),
          ),),

          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: active.withOpacity(.4), width: .5),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 6),
                    color: lightGrey.withOpacity(.1),
                    blurRadius: 12)
              ],
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(top: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: CustomText(
                        text: "List des Commandes",
                        color: lightGrey,
                        weight: FontWeight.bold,
                        size: 20,
                      ),
                    ),
                   Container(
                     margin: EdgeInsets.symmetric(horizontal: 20),
                     child:  IconButton(
                         icon:  Icon(Icons.refresh, color: active,size: 30),
                         onPressed: () {
                           setState(() {
                             isLoaded = false;
                             getData();
                           });
                         }
                     ),
                   )
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
                    child: (isLoaded)
                        ? DataTable2(
                      columnSpacing: 12,
                      dataRowHeight: 56,
                      headingRowHeight: 40,
                      horizontalMargin: 12,
                      minWidth: 600,
                      columns: const [
                        DataColumn2(
                          label: HeadingText(text: 'Numéro de piece'),
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
                          label: HeadingText(text: 'Actions'),
                        ),
                      ],
                      rows: generateDataRows(cmdList),

                    )
                        : const CustomText(text: 'problem serveur'),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  unlockCmd(Cmd cmd) {
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
              "Voulez-vous vraiment déverrouiller la commande : ${cmd.bcc_nupi} ?",
              style: TextStyle(
                color: dark,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Cmd updatedCmd = await ApiService().unlockCommande(cmd);
                setState(() {
                  cmd.bcc_val = updatedCmd.bcc_val; // Assuming cmd.ver is boolean
                });
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0), // Ajout du padding
                child: Text(
                  "oui",
                  style: TextStyle(
                      color: Colors.white), // Couleur du texte du bouton
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
              child: Padding(
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

  List<DataRow> generateDataRows(List<Cmd> commandeList) {
    return commandeList.map((commande) {
      return DataRow(
        cells: [
          DataCell(CustomSelectableText(text: commande.bcc_nupi)),
          DataCell(CustomText(text: commande.bcc_lcli)),
          DataCell(CustomText(text: commande.bcc_eta)),
          DataCell(CustomText(text: commande.bcc_dat)),
          DataCell(Row(
            children: [
              IconButton(
                  icon: const Icon(Icons.unfold_more, color: dark),
                  onPressed: () {
                    showDetails(context, commande);
                  },
                  tooltip: "Plus d\'informations"),
              SizedBox(width: 20,),
              IconButton(
                  icon: const Icon(Icons.remove_red_eye, color: active),
                  onPressed: () {
                    cmdController.selectedNumpiece(commande.bcc_nupi);
                    menuController.changeActiveitemTo(GalleryPageDisplayName);
                    navigationController.navigateTo(GalleryPageRoute);
                  },
                  tooltip: "Details articles"),
              SizedBox(width: 20,),
              Visibility(
                visible: commande.bcc_val && (commande.bcc_eta == StatusConstants.TERMINE) ,
                child: IconButton(
                    icon: const Icon(Icons.lock_open_outlined, color: green),
                    tooltip: "Déverrouiller la commande",
                    onPressed: () {
                      var currUser = authenticationManager.currUser?.value;
                      if(currUser?.role == "ADMIN"){
                      unlockCommande(commande);

                      }else {
                        Get.defaultDialog(
                            backgroundColor: light,
                            title: "Attention",
                            middleText: 'vous n\'êtes pas autorisé à déverrouiller',
                            textConfirm: 'OK',
                            confirmTextColor: Colors.white,
                            onConfirm: () {
                              Get.back();
                            });
                      }

                    }),
              ),
            ],
          )),
        ],
      );
    }).toList();
  }

  unlockCommande(Cmd commande) {
    unlockCmd(commande);
  }

  Future selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(200),
        lastDate: DateTime(2030),
        locale: const Locale('fr', 'FR'),

    );
    if (picked != null) {
      setState(() {
        transactionDateController.text = DateFormat('dd-MM-yyyy HH:mm:ss').format(picked);
      });
    }
  }

  void showDetails(BuildContext c, Cmd data) async {
    await showDialog<bool>(
    context: c,
    builder: (_) => CustomDialog(
    showPadding: false,
    child: CmdDetails(data: data),
    ),
    );
  }
}
