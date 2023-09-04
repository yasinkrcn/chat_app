// ignore_for_file: unused_element, must_be_immutable

import 'package:chat_app/core/_core_exports.dart';

class AppTextFormField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final bool? isBorder;
  final bool autoFocus;
  final bool enabled;
  final int? maxLines;
  final double? width;
  bool isObscure;
  final double? height;
  final Widget? prefixIcon;
  Widget? suffixIcon;
  final void Function()? onTap;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextAlignVertical? textAlignVertical;
  final TextInputType? keyboardType;
  final Color? fillColor;
  final Function(String)? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;

  AppTextFormField._({
    Key? key,
    this.labelText,
    this.hintText,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.width,
    this.onChanged,
    this.validator,
    this.maxLines,
    this.height = 65,
    this.isBorder = true,
    this.enabled = true,
    this.autoFocus = false,
    this.isObscure = false,
    this.textAlignVertical,
    this.keyboardType = TextInputType.text,
    this.fillColor,
    this.onFieldSubmitted,
    this.inputFormatters,
  }) : super(key: key);

  factory AppTextFormField.standart({
    double? width,
    double? height,
    String? hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? labelText,
    bool enabled = true,
    bool? isBorder = true,
    bool autoFocus = false,
    void Function(String)? onChanged,
    TextEditingController? controller,
    String? Function(String?)? validator,
    TextAlignVertical? textAlignVertical,
    TextInputType? keyboardType,
    Color? fillColor,
    final Function(String)? onFieldSubmitted,
    final List<TextInputFormatter>? inputFormatters,
  }) {
    return AppTextFormField._(
      width: width,
      height: height,
      enabled: enabled,
      hintText: hintText,
      isBorder: isBorder,
      onChanged: onChanged,
      validator: validator,
      controller: controller,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      autoFocus: autoFocus,
      labelText: labelText,
      textAlignVertical: TextAlignVertical.center,
      keyboardType: keyboardType,
      fillColor: fillColor,
      onFieldSubmitted: onFieldSubmitted,
      inputFormatters: inputFormatters,
    );
  }

  factory AppTextFormField.obscure({
    double? width,
    double? height,
    String? hintText,
    Widget? prefixIcon,
    bool? isBorder = true,
    String? labelText,
    void Function(String)? onChanged,
    TextEditingController? controller,
    String? Function(String?)? validator,
    TextAlignVertical? textAlignVertical,
    TextInputType? keyboardType,
  }) {
    return AppTextFormField._(
      width: width,
      isObscure: true,
      isBorder: isBorder,
      hintText: hintText,
      onChanged: onChanged,
      labelText: labelText,
      validator: validator,
      controller: controller,
      prefixIcon: prefixIcon,
      textAlignVertical: TextAlignVertical.center,
      keyboardType: keyboardType,
    );
  }

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  bool isObscure = false;

  @override
  void initState() {
    super.initState();
    isObscure = widget.isObscure;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? ScreenSize().getWidthPercent(1),
      height: widget.height,
      constraints: const BoxConstraints(minHeight: 46, maxHeight: 200),
      child: TextFormField(
        onChanged: widget.onChanged,
        validator: widget.validator,
        controller: widget.controller,
        obscureText: isObscure,
        autofocus: widget.autoFocus,
        enabled: widget.enabled,
        keyboardType: widget.keyboardType,
        enableInteractiveSelection: true,
        textAlignVertical: widget.textAlignVertical,
        cursorColor: AppColors.black,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          fillColor: widget.fillColor ?? AppColors.white,
          filled: true,
          hintText: widget.hintText,
          labelText: widget.labelText,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.isObscure ? getObscureSuffixIcon() : widget.suffixIcon,
          prefixIconColor: AppColors.black,
          suffixIconColor: AppColors.black,
          focusColor: AppColors.black,
          hoverColor: AppColors.black,
          hintStyle: TextStyle(color: AppColors.black.withOpacity(.6)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(color: AppColors.grey, width: widget.isBorder! ? 2 : 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(color: AppColors.grey, width: widget.isBorder! ? 2 : 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(color: Colors.grey, width: widget.isBorder! ? 1 : 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            borderSide: BorderSide(color: Colors.grey, width: widget.isBorder! ? 1 : 2),
          ),
        ),
        inputFormatters: widget.inputFormatters,
        textInputAction: TextInputAction.send,
        maxLines: widget.maxLines ?? 1,
        minLines: 1,
        onFieldSubmitted: widget.onFieldSubmitted,
      ),
    );
  }

  Widget getObscureSuffixIcon() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isObscure = !isObscure;
        });
      },
      child: Icon(isObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined),
    );
  }
}
