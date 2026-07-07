import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:provider/provider.dart';

import '../theme/app_colors.dart';


// ignore: must_be_immutable
class DefaultTextFormField extends StatefulWidget {
  String hintText;
  TextEditingController? controller;
  void Function(String)? onChanged;
  String? prefixIconImageName;
  String? Function(String?)? validator;
  bool isPassword;
  final Color? fillColor;
  final Color?  borderColor;

  DefaultTextFormField({
    super.key,
    required this.hintText,
    this.controller,
    this.onChanged,
    this.prefixIconImageName,
    this.validator,
    this.isPassword = false,
    this.fillColor,
    this.borderColor,
  });

  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
  late bool isObscure = widget.isPassword;
  @override
  Widget build(BuildContext context) {

    return TextFormField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        color:
        Theme.of(context).brightness == Brightness.dark ? AppColors.darkGray : AppColors.darkGray,
      ),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: widget.borderColor ?? AppColors.simony,
          ),
        ),
        hintText: widget.hintText,
        hintStyle: Theme.of(context).textTheme.titleMedium
            ?.copyWith(
          color:
          Theme.of(context).brightness == Brightness.dark ? AppColors.darkGray : AppColors.darkGray,
        ),
        filled: true,
        fillColor: widget.fillColor ??
            (Theme.of(context).brightness == Brightness.dark
                ? AppColors.darkGray
                : AppColors.simony),
        iconColor: AppColors.darkGray,
        prefixIcon:
            widget.prefixIconImageName == null
                ? null
                : SvgPicture.asset(
                  'assets/icons/${widget.prefixIconImageName}.svg',
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).brightness == Brightness.dark ? AppColors.darkGray : AppColors.darkGray,
                    BlendMode.srcIn,
                  ),
                  height: 24,
                  width: 24,
                  fit: BoxFit.scaleDown,
                ),
        suffixIcon:
            widget.isPassword
                ? IconButton(
                  onPressed: () {
                    isObscure = !isObscure;
                    setState(() {});
                  },
                  icon: Icon(
                    isObscure
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color:
                        Theme.of(context).brightness == Brightness.dark
                            ? AppColors.darkGray
                            : AppColors.darkGray,
                  ),
                )
                : null,
      ),
      validator: widget.validator,
      obscureText: isObscure,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      // onTapOutside: (_)=> FocusManager.instance.primaryFocus?.unfocus(),


    );
  }
}
