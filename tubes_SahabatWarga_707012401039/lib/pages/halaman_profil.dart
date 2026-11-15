import 'package:flutter/material.dart';

import '../navigation/app_routes.dart';

class HalamanProfil extends StatelessWidget {
  const HalamanProfil({super.key});

  @override
  Widget build(BuildContext context) {
    // Cukup gunakan widget konten tanpa Scaffold dan tanpa bottomNavigationBar
    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
        const SizedBox(height: 16),
        const Center(
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Color(0xFF80CBC4),
            child: Icon(Icons.person, size: 50, color: Color(0xFF004D40)),
          ),
        ),
        const SizedBox(height: 16),
        const Center(
          child: Text(
            'Zahran Rauhillah Raziq',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 4),
        const Center(
          child: Text(
            'Zahran@sahabatwarga.com',
            style: TextStyle(color: Colors.black54),
          ),
        ),
        const SizedBox(height: 32),
        Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Pengaturan'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.pengaturan);
            },
          ),
        ),
      ],
    );
  }
}
