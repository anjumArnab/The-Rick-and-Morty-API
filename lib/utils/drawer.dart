
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final String accountName;
  final String profilePictureUrl;
  final String accountEmail;
  final VoidCallback onExit;

  const CustomDrawer({
    super.key,
    required this.accountName,
    required this.profilePictureUrl,
    required this.accountEmail,
    required this.onExit,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(accountName),
            accountEmail: Text(accountEmail),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  profilePictureUrl),
            ),
            decoration: const BoxDecoration(
              color: Colors.black26// Set background color
            ),
          ),
          const Divider(),
          // Exit Button
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Colors.black),
            title: const Text('Exit'),
            onTap: onExit, // Add exit functionality here
          ),
        ],
      ),
    );
  }
}
