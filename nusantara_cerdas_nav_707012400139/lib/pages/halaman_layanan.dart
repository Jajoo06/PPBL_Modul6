import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/favorit_cubit.dart';
import '../navigation/app_routes.dart';

class HalamanLayanan extends StatelessWidget {
  const HalamanLayanan({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Material(
            color: colorScheme.surface,
            child: TabBar(
              labelColor: colorScheme.primary,
              unselectedLabelColor: colorScheme.onSurfaceVariant,
              indicatorColor: colorScheme.primary,
              tabs: const [
                Tab(icon: Icon(Icons.assignment), text: 'Perizinan'),
                Tab(icon: Icon(Icons.health_and_safety), text: 'Kesehatan'),
                Tab(icon: Icon(Icons.directions_bus), text: 'Transportasi'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildDaftarLayanan(context, [
                  'Izin Usaha Mikro',
                  'Persetujuan Bangunan Gedung (PBG)',
                  'Izin Reklame & Reklame Papan',
                ]),
                _buildDaftarLayanan(context, [
                  'Pendaftaran Antrean Puskesmas',
                  'Layanan Skrining Kesehatan Warga',
                  'Pendaftaran Posyandu Lansia & Balita',
                ]),
                _buildDaftarLayanan(context, [
                  'Penerbitan Kartu Langganan Bus',
                  'Pemeriksaan Uji Berkala Kendaraan (KIR)',
                  'Dispensasi Jalur Khusus Kendaraan',
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDaftarLayanan(BuildContext context, List<String> daftar) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: daftar.length,
      itemBuilder: (context, index) {
        final namaLayanan = daftar[index];

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: ListTile(
            title: Text(
              namaLayanan,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            trailing: BlocSelector<FavoritCubit, List<String>, bool>(
              selector: (state) => state.contains(namaLayanan),
              builder: (context, isFavorit) {
                return IconButton(
                  icon: Icon(
                    isFavorit ? Icons.star : Icons.star_border,
                    color: isFavorit
                        ? Colors.amber
                        : colorScheme.onSurfaceVariant,
                  ),
                  onPressed: () {
                    final cubit = context.read<FavoritCubit>();
                    if (isFavorit) {
                      cubit.batalTandai(namaLayanan);
                    } else {
                      cubit.tandai(namaLayanan);
                    }
                  },
                );
              },
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.detailLayanan,
                arguments: namaLayanan,
              );
            },
          ),
        );
      },
    );
  }
}