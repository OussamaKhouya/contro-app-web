import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web/constants/style.dart';
import 'package:flutter_web/controllers/commande_controller.dart';
import 'package:flutter_web/models/cmd.dart';
import 'package:flutter_web/models/lcmd.dart';
import 'package:flutter_web/pages/cmd/widgets/custom_dialog.dart';
import 'package:flutter_web/pages/cmd/widgets/lcmd_details.dart';
import 'package:flutter_web/services/api.dart';
import 'package:flutter_web/widgets/custom_text.dart';
import 'package:flutter_web/widgets/heading_text.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:get/get.dart';

class GalleryTable extends StatefulWidget {
  const GalleryTable({super.key});

  @override
  State<GalleryTable> createState() => _RelevantCmdsState();
}

class _RelevantCmdsState extends State<GalleryTable> {
  final CommandeController cmdController = Get.find();
  final CommandeController cmdControllerPut = Get.put(CommandeController());
  List<LCmd> lcList = [];
  var isLoaded = false;
  Future<List<String>>? listOfUrls;
  final inputSearch = TextEditingController();
  String errorMessage = '';
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    lcList = await ApiService().fetchLigneC(cmdController.selectedNumpiece.value);
    if (lcList != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  loadGallery() {
    setState(() {
      listOfUrls = ApiService().getImagesUrl(
          cmdController.selectedNumpiece.value,
          cmdController.selectedNumero.value);
    });
  }

  clearGallery() {}

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [

        const SizedBox(
          height: 10,
        ),
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
                    text: "List des Articles",
                    color: lightGrey,
                    weight: FontWeight.bold,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Visibility(
                visible: isLoaded,
                replacement: const Center(child: CircularProgressIndicator()),
                child: SizedBox(
                  height: (56 * lcList.length) + 40,
                  child: (isLoaded)
                      ? DataTable2(
                          columnSpacing: 12,
                          dataRowHeight: 56,
                          headingRowHeight: 40,
                          horizontalMargin: 12,
                          minWidth: 600,
                          columns: const [
                            DataColumn2(
                              label: HeadingText(text: "Numero"),
                              size: ColumnSize.L,
                            ),
                            DataColumn(
                              label: HeadingText(text: "Article"),
                            ),
                            DataColumn(
                              label: HeadingText(text: "Quantité"),
                            ),
                            DataColumn(
                              label: HeadingText(text: "Photo"),
                            ),
                            DataColumn(
                              label: HeadingText(text: "Action"),
                            ),
                          ],
                          rows: generateDataRows(lcList),
                        )
                      : const CustomText(text: 'problem serveur'),
                ),
              )
            ],
          ),
        ),
        FutureBuilder(
          future: listOfUrls,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Container();
              case ConnectionState.active:
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              case ConnectionState.done:
                if (snapshot.hasData) {
                  List<String> nonNullableList = snapshot.data ?? [];
                  return (nonNullableList.isNotEmpty)
                      ? Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20),
                                child: Container(
                                  width: 300,
                                  alignment: Alignment.center,
                                  child: GalleryImage(
                                      showAppBar: false,
                                      galleryBackgroundColor: light,
                                      imageUrls: nonNullableList,
                                      numOfShowImages:
                                          (nonNullableList.length)),
                                )),
                          ],
                        )
                      : const Text("Pas d'images pour cet article");
                } else if (snapshot.hasError) {
                  return const Text('Something went wrong!');
                }
              default:
                return const Text("default");
            }
            return const Text("default");
          },
        )
      ],
    );
  }

  unlockCmd(Cmd cmd) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: light,
          title: const Text(
            "Confirmation",
            style: TextStyle(color: Colors.black54),
          ),
          content: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              "Voulez-vous vraiment verrouiller la commande : ${cmd.bcc_nupi} ?",
              style: const TextStyle(
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
              child: const Padding(
                padding: EdgeInsets.all(8.0), // Ajout du padding
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
              child: const Padding(
                padding: EdgeInsets.all(8.0), // Ajout du padding
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

  List<DataRow> generateDataRows(List<LCmd> lcmdList) {
    return lcmdList.map((lc) {
      return DataRow(
        cells: [
          DataCell(CustomText(text: lc.a_bcc_num)),
          DataCell(CustomText(text: lc.a_bcc_lib)),
          DataCell(CustomText(text: lc.a_bcc_qua)),
          DataCell(CustomText(text: (double.parse(lc.nph1) + double.parse(lc.nph2) + double.parse(lc.phb) + double.parse(lc.phc)).toString())),
          DataCell(
              Row(children: [
                IconButton(
                    icon: const Icon(Icons.unfold_more, color: dark),
                    onPressed: () {
                      showDetails(context, lc);
                    },
                    tooltip: "Plus d\'informations"),
                SizedBox(width: 20,),
                IconButton(
                    icon: const Icon(Icons.image, color: active),
                    onPressed: () {
                      cmdController.selectedNumero(lc.a_bcc_num);
                      loadGallery();
                    }),

              ],)


          ),
        ],
      );
    }).toList();
  }


  void showDetails(BuildContext c, LCmd data) async {
    await showDialog<bool>(
      context: c,
      builder: (_) => CustomDialog(
        showPadding: false,
        child: LCmdDetails(data: data),
      ),
    );
  }
}
