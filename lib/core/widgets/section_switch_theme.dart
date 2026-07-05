import 'package:flutter/material.dart';

import '../theme/theme_cubit.dart';
class SectionSwitchTheme extends StatelessWidget {
  const SectionSwitchTheme({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: context.isDark
            ? Colors.grey.shade800
            : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.brown.shade200,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.dark_mode_outlined,
            color: Colors.brown,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "Dark Mode",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: context.isDark
                    ? Colors.white
                    : Colors.black87,
              ),
            ),
          ),
          Switch(
            value: context.isDark,
            activeColor: Colors.white,
            activeTrackColor: Colors.brown,
            inactiveThumbColor: Colors.brown,
            inactiveTrackColor: Colors.brown.shade200,
            onChanged: (_) {
              context.theme.toggleTheme();
            },
          ),
        ],
      ),
    );
  }
}
