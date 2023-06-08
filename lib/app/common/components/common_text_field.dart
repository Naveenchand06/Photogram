import 'package:cinepebble_social/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CommonTextField extends StatefulWidget {
  const CommonTextField({
    super.key,
    required this.fieldname,
    required this.hintText,
    this.onChange,
    this.onSubmit,
    this.validate,
    this.fieldController,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.fieldAction = TextInputAction.next,
    this.maxLines = 1,
  });

  final String fieldname;
  final String hintText;
  final bool isPassword;
  final Function(String)? onChange;
  final Function(String)? onSubmit;
  final TextInputType keyboardType;
  final TextEditingController? fieldController;
  final TextInputAction fieldAction;
  final String? Function(String?)? validate;
  final int maxLines;

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  bool showPassword = false;

  void _passwordVisbilityFunction() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.fieldname,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          controller: widget.fieldController,
          onChanged: widget.onChange,
          onFieldSubmitted: widget.onSubmit,
          validator: widget.validate,
          keyboardType: widget.keyboardType,
          textInputAction: widget.fieldAction,
          obscureText: widget.isPassword ? showPassword : false,
          style: const TextStyle(fontSize: 16.0, color: Colors.black),
          maxLines: widget.maxLines,
          cursorColor: AppColor.appColor,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromARGB(255, 233, 233, 233),
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontSize: 14.0,
              color: Colors.grey.shade700,
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: _passwordVisbilityFunction,
                    icon: showPassword
                        ? const Icon(
                            Icons.visibility,
                          )
                        : const Icon(
                            Icons.visibility_off,
                          ),
                  )
                : null,
            contentPadding: const EdgeInsets.all(16.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                width: 1.0,
                strokeAlign: 10.0,
                color: AppColor.appColor,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
