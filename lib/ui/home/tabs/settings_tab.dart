import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Themeprovider.dart';

class SettingsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Dark Mode',
                style: TextStyle(fontSize: 18),
              ),
              Switch(
                value: themeProvider.isDarkMode,
                onChanged: (value) {
                  themeProvider.toggleTheme(value); // Toggle theme
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
