import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';

@immutable
class CustomFormField extends StatefulWidget {
  // const CustomFormField({Key? key}) : super(key: key);
  final String labelText;
  bool isPassword;
  final String? Function(String?) validatorFunction;
  final TextEditingController? controller;
  final Color primaryColor;
  final Color textColor;
  final Color? textFieldBgColor;
  final bool isLabelCenter;
  final bool readOnly;
  final bool showLabel;
  Widget? suffixWidget;
  Widget? prefixWidget;
  int? maxLength;
  List<TextInputFormatter>? textInputFormatters;
  final BorderRadius? borderRadius;
  final TextInputType? textInputType;

  CustomFormField({
    this.textInputFormatters,
    this.maxLength,
    required this.labelText,
    this.isPassword = false,
    this.readOnly = false,
    this.showLabel = false,
    this.controller,
    this.suffixWidget,
    this.prefixWidget,
    required this.validatorFunction,
    required this.primaryColor,
    required this.textColor,
    this.textFieldBgColor,
    required this.isLabelCenter,
    this.borderRadius,
    this.textInputType,
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.textInputType,
      readOnly: widget.readOnly,
      controller: widget.controller,
      obscureText: widget.isPassword,
      validator: widget.validatorFunction,
      style: TextStyling.medium,
      cursorColor: widget.primaryColor.withOpacity(0.5),
      maxLength: widget.maxLength,
      inputFormatters: widget.textInputFormatters,
      decoration: InputDecoration(
        counterText: '',
        prefixIcon: widget.prefixWidget != null
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: widget.prefixWidget,
              )
            : null,
        prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
        filled: false,
        // filled: true,
        fillColor: widget.textFieldBgColor ?? AppColors.appDarkBlue,
        suffixIcon: widget.labelText.contains('Password')
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    widget.isPassword = !widget.isPassword;
                  });
                },
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: Icon(
                    widget.isPassword ? Icons.visibility : Icons.visibility_off,
                    color: widget.textColor.withOpacity(0.5),
                    size: 16,
                  ),
                ),
              )
            : widget.suffixWidget,
        contentPadding: const EdgeInsets.only(left: 12, right: 12),
        floatingLabelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: widget.textColor.withOpacity(0.5),
            ),
        floatingLabelBehavior:
            !widget.showLabel ? FloatingLabelBehavior.never : null,
        label: widget.isLabelCenter
            ? Center(
                child: Text(
                  widget.labelText,
                  style: TextStyling.thin.copyWith(
                    fontSize: 13.sp,
                  ),
                ),
              )
            : Text(
                widget.labelText,
                style: TextStyling.thin.copyWith(
                  fontSize: 13.sp,
                ),
              ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.red,
          ),
          borderRadius: widget.borderRadius ??
              const BorderRadius.all(
                Radius.circular(8),
              ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.red,
          ),
          borderRadius: widget.borderRadius ??
              const BorderRadius.all(
                Radius.circular(8),
              ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            // color: widget.,
            color: AppColors.appSkyBlue.withOpacity(0.5),
          ),
          borderRadius: widget.borderRadius ??
              const BorderRadius.all(
                Radius.circular(8),
              ),
        ),
        // enabledBorder: OutlineInputBorder(
        //   // borderSide: BorderSide.none,
        //   borderSide: BorderSide(
        //     // color: widget.,
        //     color: AppColors.grey,
        //   ),
        //   borderRadius: widget.borderRadius ??
        //       BorderRadius.all(
        //         Radius.circular(8),
        //       ),
        // ),
        border: InputBorder.none,
      ),
    );
  }
}
