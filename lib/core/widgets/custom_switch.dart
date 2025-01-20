

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../constants/app_colors.dart';

class CustomSwitchRow extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String label;

  const CustomSwitchRow({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FlutterSwitch(
          width: 44.0,
          height: 24.0,
          toggleSize: 20.0,
          value: value,
          borderRadius: 12.0,
          padding: 2.0,
          activeToggleColor: Colors.white,
          inactiveToggleColor: Colors.white,
          activeColor: AppColors.middleBlue,
          inactiveColor: Colors.grey[300]!,
          duration: const Duration(milliseconds: 150),
          onToggle: onChanged,
        ),
        const SizedBox(width: 12.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: value ? null : Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
