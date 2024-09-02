import 'package:chtx/services/Theme/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool listen1 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Settings'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Dark Mode',
              style: TextStyle(
                  fontSize: 20, color: Theme.of(context).colorScheme.tertiary),
            ),
            // Consumer<ThemeProvider>(
            //   builder: (context, ThemeProvider, child) {
            //     return CupertinoSwitch(
            //       value: ThemeProvider.isdarkMode,
            //       onChanged: (value) {
            //         ThemeProvider.toggletheme();
            //       },
            //     );
            //   },
            // )
            Switch.adaptive(
                activeColor: Theme.of(context).colorScheme.primary,
                activeTrackColor:
                    Theme.of(context).colorScheme.onPrimaryContainer,
                inactiveThumbColor:
                    Theme.of(context).colorScheme.onPrimaryContainer,
                value: Provider.of<ThemeProvider>(context, listen: false)
                    .isDarkMode,
                onChanged: (bool value) {
                  setState(() {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .toggletheme();
                  });
                }),
          ],
        ),
      ),
    );
  }
}
