import 'package:flutter/material.dart';
import 'style.dart';

class ProfileField extends StatelessWidget {
  final String label;
  final Widget icon;
  final String text;
  final Widget? suffixIcon;

  const ProfileField({
    super.key,
    required this.label,
    required this.icon,
    required this.text,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 58,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: ProfileStyles.lightBorder),
          ),
          child: Row(
            children: [
              icon,
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  text,
                  style: ProfileStyles.fieldText(context),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (suffixIcon != null) suffixIcon!,
            ],
          ),
        ),
        Positioned(
          left: 16,
          top: -8,
          child: Container(
            color: ProfileStyles.pageBg,
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              label,
              style: ProfileStyles.label(context),
            ),
          ),
        ),
      ],
    );
  }
}