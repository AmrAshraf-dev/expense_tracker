import 'package:expense_tracker/utils/colors.dart';
import 'package:flutter/material.dart';

class EntryField extends StatefulWidget {
  final String? hintText, labelText;
  //final TextStyle? labelStyle;
  final TextStyle? hintStyle, style, labelStyle;
  final bool isPassword,
      isAddressPage,
      isPaymentPageForPadding,
      isSecureTextForEver,
      isBigContentText,
      readOnly;
  final Null Function(String) onChange;
  final Function()? onSubmit;
  final String? Function(String?) validator;
  final int? maxlines;
  final TextInputType keyboardType, keyboardTypeNumbers, inputFormatters;
  final String? initialValue;
  final String? type;
  final TextEditingController? fieldTextEditingController;
  final TextAlign textAlign;
  final FocusNode? fieldFocusNode;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Iterable<String>? autofillHints;
  final InputBorder? border;
  const EntryField({
    Key? key,
    this.hintText,
    this.hintStyle,
    this.style,
    required this.isPassword,
    required this.labelText,
    required this.onChange,
    required this.validator,
    this.labelStyle,
    this.initialValue,
    this.suffixIcon,
    this.prefixIcon,
    this.type,
    this.fieldTextEditingController,
    this.onSubmit,
    this.maxlines,
    // this.textfieldSearchController,
    this.autofillHints,
    this.fieldFocusNode,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
    this.keyboardTypeNumbers = TextInputType.number,
    this.inputFormatters = TextInputType.number,
    this.isAddressPage = false,
    this.isPaymentPageForPadding = false,
    this.textAlign = TextAlign.start,
    this.isSecureTextForEver = false,
    this.isBigContentText = false,
    this.border,
  })  : assert(true
            //lableText != '' && hintText != '', 'text cannot be empty'
            ),
        super(key: key);

  @override
  State<EntryField> createState() => _EntryFieldState();
}

class _EntryFieldState extends State<EntryField> {
  // keyboardType: TextInputType.number,
  final textfieldSearchController = TextEditingController();
  // Initially password is obscure
  bool _obscureText = true;

  late final _textFieldFocus = FocusNode()
    ..addListener(() {
      setState(() {});
    });

  @override
  Widget build(BuildContext context) {
    // const height = 100;
    return TextFormField(
      controller: widget.fieldTextEditingController,
      initialValue: widget.initialValue,
      readOnly: widget.readOnly,
      focusNode: _textFieldFocus,
      keyboardType: widget.keyboardType,
      onChanged: widget.onChange,
      validator: widget.validator,
      textAlign: widget.textAlign,
      style: widget.style,

      maxLines: widget.isBigContentText ? null : 1, //widget.maxlines ?? 0,
      obscureText: widget.isPassword ? _obscureText : false,

      // textDirection: locale.locale.languageCode == 'ar'
      //     ? TextDirection.ltr
      //     : TextDirection.rtl,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: widget.hintStyle,
        labelText: widget.labelText,
        labelStyle: widget.labelStyle,
        fillColor: _textFieldFocus.hasFocus
            ? MyColors.white
            //  MyColors.lightGreen
            : MyColors.greyWhite3,
        // fillColor: MyColors.greyWhite3,
        prefixIcon: widget.suffixIcon,
        prefix: widget.prefixIcon,
        suffixIcon: widget.isPassword
            ? widget.isSecureTextForEver
                ? const Offstage()
                : IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: _obscureText
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                    color: _obscureText
                        ? _textFieldFocus.hasFocus
                            ? MyColors.primaryColor
                            : MyColors.headerColor
                        : MyColors.primaryColor)
            : const Offstage(),
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 0, color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 0, color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
    );
  }
}
