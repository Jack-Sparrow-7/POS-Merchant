import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos_merchant/core/constants/app_icons.dart';
import 'package:pos_merchant/core/extensions/context_extensions.dart';
import 'package:pos_merchant/core/theme/app_colors.dart';
import 'package:pos_merchant/presentation/bloc/auth/auth_bloc.dart';
import 'package:pos_merchant/presentation/bloc/auth/auth_event.dart';
import 'package:pos_merchant/presentation/bloc/auth/auth_state.dart';
import 'package:pos_merchant/presentation/validators/register_validators.dart';
import 'package:pos_merchant/presentation/widgets/auth_field.dart';
import 'package:pos_merchant/presentation/widgets/auth_form_card.dart';
import 'package:pos_merchant/presentation/widgets/auth_submit_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _businessCtrl = TextEditingController();
  final _mobileCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _businessCtrl.dispose();
    _mobileCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.neutral,
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              context.showErrorSnackBar(
                state.message ?? 'Something went wrong.',
              );
            }
            if (state is AuthAuthenticated) {
              context.go('/home');
            }
          },
          builder: (context, state) {
            bool isLoading = state is AuthLoading;
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 512),
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(
                      context,
                    ).copyWith(scrollbars: false),
                    child: SingleChildScrollView(
                      clipBehavior: Clip.none,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      child: Column(
                        children: [
                          Gap(48),
                          Text(
                            "Branding",
                            style: GoogleFonts.arizonia(
                              color: AppColors.primary,
                              fontSize: 40,
                            ),
                          ),
                          Gap(16),
                          Text(
                            "Create Your Account",
                            style: TextStyle(
                              color: AppColors.textDark,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Gap(8),
                          Text(
                            "Register your business to start billing\nand tracking sales today",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.textMedium,
                              fontSize: 16,
                            ),
                          ),
                          Gap(32),
                          AuthFormCard(
                            child: Form(
                              key: _formKey,
                              autovalidateMode: _autovalidateMode,
                              child: Column(
                                children: [
                                  AuthField(
                                    labelText: 'Full Name',
                                    labelIcon: AppIcons.user,
                                    hintText: 'Jack Dev',
                                    controller: _nameCtrl,
                                    validator: RegisterValidators.validateName,
                                  ),
                                  Gap(24),
                                  AuthField(
                                    labelText: 'BusinessName',
                                    labelIcon: AppIcons.building,
                                    hintText: 'Acme Retail Solutions',
                                    controller: _businessCtrl,
                                    validator:
                                        RegisterValidators.validateBusinessName,
                                  ),
                                  Gap(24),
                                  AuthField(
                                    labelText: 'Mobile Number',
                                    labelIcon: AppIcons.mobile,
                                    hintText: '7449261057',
                                    textInputType: .number,
                                    maxLength: 10,
                                    controller: _mobileCtrl,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    validator:
                                        RegisterValidators.validateMobileNumber,
                                  ),
                                  Gap(24),
                                  AuthField(
                                    labelText: 'Email Address',
                                    labelIcon: AppIcons.envelope,
                                    hintText: 'jacksparrow@example.com',
                                    textInputType: .emailAddress,
                                    controller: _emailCtrl,
                                    validator: RegisterValidators.validateEmail,
                                  ),
                                  Gap(24),
                                  AuthField(
                                    labelText: 'Password',
                                    labelIcon: AppIcons.lock,
                                    hintText: '*********',
                                    isPassword: true,
                                    textInputAction: .done,
                                    controller: _passwordCtrl,
                                    validator:
                                        RegisterValidators.validatePassword,
                                  ),
                                  Gap(24),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                      12,
                                      12,
                                      48,
                                      12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.neutral,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: .center,
                                      spacing: 8,
                                      children: [
                                        Icon(
                                          Icons.check_circle_outline,
                                          color: AppColors.accent,
                                        ),
                                        Expanded(
                                          child: Text(
                                            "Password must be at least 6 characters with a mix of letters and numbers.",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: AppColors.textMedium,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Gap(44),
                                  AuthSubmitButton(
                                    onPressed: isLoading
                                        ? null
                                        : () {
                                            final isValid =
                                                _formKey.currentState
                                                    ?.validate() ??
                                                false;
                                            if (!isValid) {
                                              setState(() {
                                                _autovalidateMode =
                                                    AutovalidateMode.always;
                                              });
                                              return;
                                            }
                                            context.read<AuthBloc>().add(
                                              AuthRegisterRequested(
                                                name: _nameCtrl.text.trim(),
                                                businessName: _businessCtrl.text
                                                    .trim(),
                                                mobileNumber: _mobileCtrl.text
                                                    .trim(),
                                                email: _emailCtrl.text.trim(),
                                                password: _passwordCtrl.text,
                                              ),
                                            );
                                          },
                                    child: Builder(
                                      builder: (context) {
                                        final textColor =
                                            DefaultTextStyle.of(
                                              context,
                                            ).style.color ??
                                            Colors.white;
                                        return Row(
                                          mainAxisAlignment: .center,
                                          spacing: 8,
                                          children: [
                                            if (isLoading)
                                              SizedBox(
                                                width: 16,
                                                height: 16,
                                                child:
                                                    CircularProgressIndicator(
                                                      color: textColor,
                                                      strokeWidth: 2,
                                                    ),
                                              ),
                                            const Text(
                                              "Register Business",
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                  Gap(24),
                                  Text(
                                    'By clicking "Register Business", you agree to our Terms of Service and Privacy Policy.',
                                    textAlign: .center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.textMedium,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Gap(32),
                          Row(
                            mainAxisAlignment: .center,
                            children: [
                              Text(
                                "Already have an account?",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textDark,
                                ),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  splashFactory: NoSplash.splashFactory,
                                  overlayColor: Colors.transparent,
                                ),
                                onPressed: isLoading
                                    ? null
                                    : () => context.go('/login'),
                                child: Text(
                                  "Sign in to Brand",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.accent,
                                    fontWeight: .w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Gap(48),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
