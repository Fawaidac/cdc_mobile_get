import 'package:cdc/app/data/models/paket_quesioner_model.dart';
import 'package:cdc/app/modules/quisioner/controllers/paket_questioner_controller.dart';
import 'package:cdc/app/resource/custom_textfieldform.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Container widgetInputQuesioner(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    List<Datum> data,
    int index,
    PaketQuesionerController c) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    width: MediaQuery.of(context).size.width,
    color: white,
    child: CustomTextFieldForm(
      controller: controllers[data[index].kodePertanyaan]!,
      isRequired: true,
      onChanged: (p0) {
        c.requestBody[data[index].kodePertanyaan] =
            controllers[data[index].kodePertanyaan]!.text;
      },
      label: data[index].pertanyaan,
      keyboardType: TextInputType.text,
      isEnable: true,
      inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
    ),
  );
}
