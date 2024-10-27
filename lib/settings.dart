import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;
  bool isSosEnabled = false;
  bool isNotificationsEnabled = true;
  bool isLocationSharingEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("설정"),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text("다크 모드"),
            value: isDarkMode,
            onChanged: (bool value) {
              setState(() {
                isDarkMode = value;
              });
            },
          ),
          const Divider(),
          SwitchListTile(
            title: const Text("SOS 모드"),
            value: isSosEnabled,
            onChanged: (bool value) {
              setState(() {
                isSosEnabled = value;
              });
            },
          ),
          const Divider(),
          SwitchListTile(
            title: const Text("알림 설정"),
            value: isNotificationsEnabled,
            onChanged: (bool value) {
              setState(() {
                isNotificationsEnabled = value;
              });
            },
          ),
          const Divider(),
          SwitchListTile(
            title: const Text("위치 공유"),
            value: isLocationSharingEnabled,
            onChanged: (bool value) {
              setState(() {
                isLocationSharingEnabled = value;
              });
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}