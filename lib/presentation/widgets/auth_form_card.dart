import 'package:flutter/material.dart';
import 'package:pos_merchant/core/extensions/context_extensions.dart';

class AuthFormCard extends StatelessWidget {
  const AuthFormCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: EdgeInsets.all(
        context.responsiveValue(
          mobile: 24,
          tablet: 40,
          desktop: 40,
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .08),
            blurRadius: 2,
          ),
          BoxShadow(
            offset: const Offset(0, 4.5),
            color: Colors.black.withValues(alpha: .22),
            blurRadius: 13.75,
          ),
        ],
      ),
      child: child,
    );
  }
}
