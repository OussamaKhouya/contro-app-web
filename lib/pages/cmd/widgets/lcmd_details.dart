

import 'package:flutter/material.dart';
import 'package:flutter_web/constants/style.dart';
import 'package:flutter_web/models/cmd.dart';
import 'package:flutter_web/models/lcmd.dart';
import 'package:flutter_web/widgets/custom_text.dart';

class LCmdDetails extends StatelessWidget {
  const LCmdDetails({Key? key, required this.data})
      : assert(data != null),
        super(key: key);

  final LCmd data;

  Iterable<MapEntry<String, dynamic>> get _fieldValues =>
      _onGenerateFields(data).entries;

  @override
  Widget build(BuildContext context) {
    //

    final _width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
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
      ),
    );
  }

  Map<String, String> _onGenerateFields(LCmd data) {
    final _fieldValues = {
      "Numero": data.a_bcc_num.toString(),
      "Numero de piece": data.a_bcc_nupi.toString(),
      "Description": data.a_bcc_lib.toString(),
      "Depot": data.a_bcc_dep.toString(),
      "Quantité": data.a_bcc_qua.toString(),
      "Coefficient": data.a_bcc_coe.toString(),
      "Boite": data.a_bcc_boi.toString(),
      "Quantité chargé 1": data.a_bcc_quch1.toString(),
      "Boite chargée 1": data.a_bcc_boch1.toString(),
      "Observation 1": data.a_bcc_obs1.toString(),
      "Quantité chargé 2": data.a_bcc_quch2.toString(),
      "Boite chargée 2": data.a_bcc_boch2.toString(),
      "Observation 2": data.a_bcc_obs2.toString(),
      "Photo C1": data.nph1.toString(),
      "Photo C2": data.nph2.toString(),
      "Photo Camion": data.phc.toString(),
      "Photo Bon": data.phb.toString(),
    };

    return _fieldValues;
  }
}
