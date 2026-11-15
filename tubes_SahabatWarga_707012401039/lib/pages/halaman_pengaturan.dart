import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/theme_cubit.dart';

class HalamanPengaturan extends StatefulWidget {
  const HalamanPengaturan({super.key});

  @override
  State<HalamanPengaturan> createState() => _HalamanPengaturanState();
}

class _HalamanPengaturanState extends State<HalamanPengaturan> {
  bool notifikasiAktif = true;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            secondary: Icon(
              Icons.notifications_outlined,
              color: colorScheme.primary,
            ),
            title: const Text('Notifikasi'),
            subtitle: const Text(
              'Terima informasi terbaru mengenai laporan',
            ),
            value: notifikasiAktif,
            onChanged: (value) {
              setState(() {
                notifikasiAktif = value;
              });
            },
          ),
          BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              final isDark = themeMode == ThemeMode.dark;
              return SwitchListTile(
                secondary: Icon(
                  isDark ? Icons.dark_mode : Icons.light_mode,
                  color: colorScheme.primary,
                ),
                title: const Text('Mode Gelap'),
                subtitle: Text(
                  isDark ? 'Tampilan gelap aktif' : 'Tampilan terang aktif',
                ),
                value: isDark,
                onChanged: (value) {
                  context.read<ThemeCubit>().setDarkMode(value);
                },
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Bahasa'),
            subtitle: const Text('Bahasa Indonesia'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.security),
            title: const Text('Privasi'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}