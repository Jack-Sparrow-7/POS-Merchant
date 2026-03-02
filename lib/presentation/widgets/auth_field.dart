import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pos_merchant/core/constants/app_icons.dart';
import 'package:pos_merchant/core/theme/app_colors.dart';

class AuthField extends StatefulWidget {
  const AuthField({
    super.key,
    required this.labelText,
    required this.labelIcon,
    required this.hintText,
    this.isPassword = false,
    this.textInputType = .name,
    this.textInputAction = .next,
    this.maxLength,
    this.validator,
    this.autovalidateMode,
    this.inputFormatters,
    required this.controller,
    this.showForgotPassword = false,
    this.focusNode,
    this.nextFocusNode,
  });

  final String labelText;
  final String labelIcon;
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final int? maxLength;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final List<TextInputFormatter>? inputFormatters;
  final bool showForgotPassword;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  final obsecureText = ValueNotifier<bool>(true);

  @override
  void dispose() {
    obsecureText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Row(
              mainAxisSize: .min,
              spacing: 8,
              children: [
                SvgPicture.asset(widget.labelIcon),
                Text(
                  widget.labelText,
                  style: TextStyle(
                    color: AppColors.textMedium,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            if (widget.showForgotPassword)
              TextButton(
                style: TextButton.styleFrom(
                  padding: .zero,
                  splashFactory: NoSplash.splashFactory,
                  overlayColor: Colors.transparent,
                ),
                onPressed: () => context.go('/forgotPassword'),
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.accent,
                    fontWeight: .w600,
                  ),
                ),
              ),
          ],
        ),
        Gap(8),
        ValueListenableBuilder(
          valueListenable: obsecureText,
          builder: (context, value, child) {
            return TextFormField(
              focusNode: widget.focusNode,
              controller: widget.controller,
              validator: widget.validator,
              autovalidateMode: widget.autovalidateMode,
              inputFormatters: widget.inputFormatters,
              style: TextStyle(color: AppColors.textDark, fontSize: 14),
              maxLength: widget.maxLength,
              textInputAction: widget.textInputAction,
              keyboardType: widget.textInputType,
              onEditingComplete: () {
                if (widget.textInputAction == TextInputAction.next) {
                  if (widget.nextFocusNode != null) {
                    widget.nextFocusNode!.requestFocus();
                    return;
                  }
                  FocusScope.of(context).nextFocus();
                  return;
                }
                FocusScope.of(context).unfocus();
              },
              obscureText: widget.isPassword ? value : false,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                counterText: '',
                border: _border(),
                errorBorder: _border(),
                enabledBorder: _border(),
                focusedBorder: _border(color: AppColors.primary),
                focusedErrorBorder: _border(),
                hintText: widget.hintText,
                hintStyle: TextStyle(color: AppColors.textLight, fontSize: 14),
                suffixIcon: widget.isPassword
                    ? IconButton(
                        style: IconButton.styleFrom(
                          splashFactory: NoSplash.splashFactory,
                        ),
                        onPressed: () =>
                            obsecureText.value = !obsecureText.value,
                        icon: SvgPicture.asset(
                          value ? AppIcons.eye : AppIcons.eyeSlash,
                        ),
                      )
                    : null,
              ),
            );
          },
        ),
      ],
    );
  }

  OutlineInputBorder _border({Color? color}) {
    return OutlineInputBorder(
      borderRadius: .circular(8),
      borderSide: BorderSide(color: color ?? AppColors.border),
    );
  }
}
