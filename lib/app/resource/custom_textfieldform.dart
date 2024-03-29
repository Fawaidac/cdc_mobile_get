import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class CustomTextFieldForm extends StatefulWidget {
  TextEditingController controller;
  String label;
  String? hint;
  TextInputType keyboardType;
  TextInputFormatter inputFormatters;
  bool isEnable;
  TextInputAction textInputAction;
  bool isReadOnly;
  bool isRequired;
  bool isPlaceholder;
  int isLength;
  bool isRequiredExp;
  Function()? onTap;
  Function(String)? onChanged;
  CustomTextFieldForm(
      {Key? key,
      required this.controller,
      required this.label,
      this.hint,
      required this.keyboardType,
      this.isEnable = false,
      this.isReadOnly = false,
      this.isRequired = false,
      this.isPlaceholder = false,
      this.isRequiredExp = false,
      this.isLength = 225,
      required this.inputFormatters,
      this.onTap,
      this.onChanged,
      this.textInputAction = TextInputAction.done})
      : super(key: key);

  @override
  State<CustomTextFieldForm> createState() => _CustomTextFieldFormState();
}

class _CustomTextFieldFormState extends State<CustomTextFieldForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.isRequiredExp == true)
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: Get.width,
                      child: Text(
                        widget.label,
                        style: GoogleFonts.poppins(fontSize: 12),
                      ),
                    ),
                  ),
                if (widget.isRequiredExp == false)
                  SizedBox(
                    width: Get.width / 1.2,
                    child: Text(
                      widget.label,
                      style: GoogleFonts.poppins(fontSize: 12),
                    ),
                  ),
                if (widget.isRequired == true)
                  Text(
                    "*",
                    style: AppFonts.poppins(fontSize: 12, color: red),
                  )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            textInputAction: widget.textInputAction,
            controller: widget.controller,
            onTap: widget.onTap,
            style: AppFonts.poppins(fontSize: 13, color: black),
            keyboardType: widget.keyboardType,
            enabled: widget.isEnable,
            readOnly: widget.isReadOnly,
            onChanged: widget.onChanged,
            onSaved: (val) => widget.controller = val as TextEditingController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter $widget.hintName';
              }
              return null;
            },
            inputFormatters: [
              widget.inputFormatters,
              LengthLimitingTextInputFormatter(widget.isLength),
            ],
            decoration: InputDecoration(
              // labelText: hintName,
              hintText:
                  widget.isPlaceholder == true ? widget.hint : widget.label,
              isDense: true,
              hintStyle: GoogleFonts.poppins(fontSize: 13),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color:
                      widget.isEnable ? Color(0xffF0F1F7) : Color(0xffF0F1F7),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),

              filled: true,
              fillColor: const Color(0xFFFCFDFE),
            ),
          )
        ],
      ),
    );
  }
}
