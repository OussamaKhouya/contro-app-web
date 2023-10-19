import 'package:flutter/material.dart';
import 'package:flutter_web/constants/controllers.dart';
import 'package:flutter_web/helpers/responsiveness.dart';
import 'package:flutter_web/widgets/custom_text.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import 'widgets/gallery_table.dart';

class GalleryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => Row(
          children: [
            Container(
              margin: EdgeInsets.only(top:
              ResponsiveWidget.isSmallScreen(context) ? 56 : 6
              ),
              child: CustomText(
                text: menuController.activeItem.value,
                size: 24,
                weight: FontWeight.bold,
              ),
            )
          ],
        )),

        Expanded(child:
        ListView(
          children: [
            GalleryTable()
          ],
        ))
      ],
    );
  }
}