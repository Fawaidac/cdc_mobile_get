import 'package:cdc/resource/colors.dart';
import 'package:cdc/resource/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {
  TextEditingController controller;
  String label;
  TextInputType keyboardType;
  TextInputFormatter inputFormatters;
  bool isEnable;
  bool isObscure;
  IconData icon;
  int isLength;
  bool isWhite;
  TextInputAction textInputAction;
  final Function(String)? onChange;
  Function()? onTap;

  CustomTextField(
      {Key? key,
      required this.controller,
      required this.label,
      required this.keyboardType,
      this.isEnable = false,
      this.isObscure = false,
      this.isWhite = false,
      required this.inputFormatters,
      required this.icon,
      this.isLength = 225,
      this.onTap,
      this.onChange,
      this.textInputAction = TextInputAction.done})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            textInputAction: widget.textInputAction,
            controller: widget.controller,
            obscureText: widget.isObscure,
            style: MyFont.poppins(fontSize: 13, color: black),
            keyboardType: widget.keyboardType,
            enabled: widget.isEnable,
            onChanged: (value) {
              if (widget.onChange != null) {
                widget.onChange!(value);
              }
            },
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
              hintText: widget.label,
              suffixIcon: InkWell(
                onTap: widget.onTap,
                child: Icon(
                  widget.icon,
                  color: widget.isWhite == true ? black : grey,
                ),
              ),
              isDense: true,
              hintStyle: GoogleFonts.poppins(fontSize: 13, color: grey),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true,
              fillColor: widget.isWhite == true
                  ? white
                  : Color(0xffC4C4C4).withOpacity(0.2),
            ),
          )
        ],
      ),
    );
  }
}
