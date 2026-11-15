import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/pengajuan_cubit.dart';
import '../pages/halaman_beranda.dart';
import '../pages/halaman_layanan.dart';
import '../pages/halaman_warga.dart';
import 'app_routes.dart';

class KerangkaNavigasi extends StatefulWidget {
  const KerangkaNavigasi({super.key});

  @override
  State<KerangkaNavigasi> createState() => _KerangkaNavigasiState();
}

class _KerangkaNavigasiState extends State<KerangkaNavigasi> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HalamanBeranda(),
    HalamanLayanan(),
    HalamanWarga(),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // Badge hanya me-rebuild saat totalPengajuan berubah
    final Widget ikonWargaDenganBadge =
        BlocSelector<PengajuanCubit, List<String>, int>(
          selector: (state) => state.length,
          builder: (context, total) {
            return Badge(
              isLabelVisible: total > 0,
              label: Text('$total'),
              child: const Icon(Icons.person),
            );
          },
        );

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isWideScreen = constraints.maxWidth >= 640;

        if (isWideScreen) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Nusantara Cerdas Mobile'),
              elevation: 1,
            ),
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: _currentIndex,
                  onDestinationSelected: (index) {
                    setState(() => _currentIndex = index);
                  },
                  labelType: NavigationRailLabelType.all,
                  destinations: [
                    const NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text('Beranda'),
                    ),
                    const NavigationRailDestination(
                      icon: Icon(Icons.miscellaneous_services),
                      label: Text('Layanan'),
                    ),
                    NavigationRailDestination(
                      icon: ikonWargaDenganBadge,
                      label: const Text('Warga'),
                    ),
                  ],
                ),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(child: _pages[_currentIndex]),
              ],
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(title: const Text('Nusantara Cerdas Mobile')),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(color: colorScheme.primary),
                  child: Text(
                    'Panel Balai Kota',
                    style: TextStyle(
                      color: colorScheme.onPrimary,
                      fontSize: 20,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.history),
                  title: const Text('Riwayat Laporan'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AppRoutes.riwayatLaporan);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Pengaturan Kota'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AppRoutes.pengaturanKota);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text('Tentang Aplikasi'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AppRoutes.tentangAplikasi);
                  },
                ),
                const Divider(),
                ListTile(
                  leading: Icon(Icons.exit_to_app, color: colorScheme.error),
                  title: Text(
                    'Keluar',
                    style: TextStyle(color: colorScheme.error),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AppRoutes.keluar);
                  },
                ),
              ],
            ),
          ),
          body: _pages[_currentIndex],
          bottomNavigationBar: NavigationBar(
            selectedIndex: _currentIndex,
            onDestinationSelected: (index) {
              setState(() => _currentIndex = index);
            },
            destinations: [
              const NavigationDestination(
                icon: Icon(Icons.home),
                label: 'Beranda',
              ),
              const NavigationDestination(
                icon: Icon(Icons.miscellaneous_services),
                label: 'Layanan',
              ),
              NavigationDestination(icon: ikonWargaDenganBadge, label: 'Warga'),
            ],
          ),
        );
      },
    );
  }
}