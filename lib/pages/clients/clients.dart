import 'package:flutter/material.dart';
import 'package:flutter_web/widgets/custom_text.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:flutter_web/helpers/responsiveness.dart';
import 'package:flutter_web/constants/controllers.dart';

class ClientsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => Row(
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
              child: CustomText(
                text: menuController.activeItem.value,
                size: 24,
                weight: FontWeight.bold,
              ),
            )
          ],
        )),
      ],
    );
  }
}