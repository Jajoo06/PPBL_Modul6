import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/favorit_cubit.dart';
import '../cubit/pengajuan_cubit.dart';
import '../cubit/theme_cubit.dart';
import '../navigation/app_routes.dart';

class HalamanWarga extends StatelessWidget {
  const HalamanWarga({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // 1. Pengaturan Tampilan (Mode Gelap / Terang)
        Card(
          child: BlocBuilder<ThemeCubit, ThemeMode>(
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
                onChanged: (val) {
                  context.read<ThemeCubit>().setDarkMode(val);
                },
              );
            },
          ),
        ),
        const Divider(height: 32),

        // 2. Keranjang Pengajuan
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Keranjang Pengajuan',
              style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            BlocSelector<PengajuanCubit, List<String>, int>(
              selector: (state) => state.length,
              builder: (context, total) {
                return Chip(
                  label: Text(
                    '$total item',
                    style: TextStyle(color: colorScheme.onPrimaryContainer),
                  ),
                  backgroundColor: colorScheme.primaryContainer,
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        BlocBuilder<PengajuanCubit, List<String>>(
          builder: (context, daftarPengajuan) {
            if (daftarPengajuan.isEmpty) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Belum ada layanan yang diajukan.',
                    style: TextStyle(color: colorScheme.onSurfaceVariant),
                  ),
                ),
              );
            }
            return Column(
              children: daftarPengajuan.map((nama) {
                return Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.assignment_turned_in,
                      color: colorScheme.primary,
                    ),
                    title: Text(nama),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete_outline,
                        color: colorScheme.error,
                      ),
                      onPressed: () {
                        context.read<PengajuanCubit>().hapusPengajuan(nama);
                      },
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
        const Divider(height: 36),

        // 3. Layanan Favorit
        Text(
          'Layanan Favorit',
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        BlocBuilder<FavoritCubit, List<String>>(
          builder: (context, daftarFavorit) {
            if (daftarFavorit.isEmpty) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Belum ada layanan favorit.',
                    style: TextStyle(color: colorScheme.onSurfaceVariant),
                  ),
                ),
              );
            }
            return Column(
              children: daftarFavorit.map((nama) {
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.star, color: Colors.amber),
                    title: Text(nama),
                    trailing: TextButton(
                      child: const Text('Buka'),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.detailLayanan,
                          arguments: nama,
                        );
                      },
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}