import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/laporan_cubit.dart';
import '../navigation/app_routes.dart';

class HalamanBeranda extends StatelessWidget {
  const HalamanBeranda({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              color: Colors.teal.shade700,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Selamat Datang di Sahabat Warga',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Kawal aspirasi dan pembenahan lingkungan RT/RW bersama warga lainnya.',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 16),
                    // Data bersama ditampilkan sebagai ringkasan reaktif
                    BlocSelector<LaporanCubit, List<ItemLaporan>, int>(
                      selector: (state) =>
                          state.where((l) => l.status == 'Menunggu').length,
                      builder: (context, totalMenunggu) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '$totalMenunggu laporan warga sedang menunggu tanggapan',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Laporan Perlu Perhatian',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            BlocBuilder<LaporanCubit, List<ItemLaporan>>(
              builder: (context, daftarLaporan) {
                return Column(
                  children: daftarLaporan.map((laporan) {
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.campaign, color: Colors.teal),
                        title: Text(laporan.judul),
                        subtitle: Text(
                          '${laporan.lokasi} • ${laporan.jumlahDukungan} dukungan',
                        ),
                        trailing: Text(
                          laporan.status,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: laporan.status == 'Diproses'
                                ? Colors.orange
                                : Colors.blueGrey,
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.detailLaporan,
                            arguments: laporan.id,
                          );
                        },
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
