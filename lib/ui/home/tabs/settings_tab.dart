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
          SizedBox(height: 20), // Add space between switch and button
          ElevatedButton(
            onPressed: () {
              themeProvider.toggleTheme(!themeProvider.isDarkMode); // Toggle theme
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(themeProvider.isDarkMode
                      ? 'Switched to Dark Mode'
                      : 'Switched to Light Mode'),
                ),
              );
            },
            child: Text(
              themeProvider.isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode',
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

