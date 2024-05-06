import 'package:flutter/material.dart';

class SettingsButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const SettingsButtonWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      height: 40,
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey, width: 0.5),
      ),
      child: TextButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.settings_outlined),
        label: const Text(
          'Show settings',
          style: TextStyle(),
        ),
      ),
    );
  }
}
