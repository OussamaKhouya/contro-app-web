

import 'package:flutter/material.dart';
import 'package:flutter_web/constants/style.dart';
import 'package:flutter_web/models/cmd.dart';
import 'package:flutter_web/widgets/custom_text.dart';

class OtherDetails extends StatelessWidget {
  const OtherDetails({Key? key, required this.data})
      : assert(data != null),
        super(key: key);

  final Cmd data;

  Iterable<MapEntry<String, dynamic>> get _fieldValues =>
      _onGenerateFields(data).entries;

  @override
  Widget build(BuildContext context) {
    //

    final _width = MediaQuery.of(context).size.width;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const CloseButton(),
        for (final _fieldValue in _fieldValues) ...[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: _width * 0.1,
                  child: CustomText(text: _fieldValue.key,weight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 30,
                ),
                SizedBox(
                  width: _width * 0.1,
                  child: CustomText(text:_fieldValue.value, color: dark),
                )
              ],
            ),
          ),
        ],
      ],
    );
  }

  Map<String, String> _onGenerateFields(Cmd data) {
    final _fieldValues = {
      "Numero de piece": data.bcc_nupi.toString(),
      "Date": data.bcc_dat.toString(),
      "Date de chargement 1": data.bcc_dach1.toString(),
      "Date de chargement 2": data.bcc_dach2.toString(),
      "Client": data.bcc_lcli,
      "rep": data.bcc_lrep,
      "Expert": data.bcc_lexp,
      "vehicule": data.bcc_veh,
      "Etat": data.bcc_eta,
      "validé": data.bcc_val?"oui":"non",
      "Operateur de saisie": data.bcc_usr_sai,
      "Commercial": data.bcc_usr_com,
      "Control 1": data.bcc_usr_con1,
      "Control 2": data.bcc_usr_con2,
      "Superviseur": data.bcc_usr_sup,
    };

    return _fieldValues;
  }
}
