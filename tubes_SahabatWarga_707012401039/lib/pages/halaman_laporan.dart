import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/laporan_cubit.dart';
import '../navigation/app_routes.dart';

class HalamanLaporan extends StatelessWidget {
  const HalamanLaporan({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LaporanCubit, List<ItemLaporan>>(
      builder: (context, daftarLaporan) {
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: daftarLaporan.length,
          itemBuilder: (context, index) {
            final laporan = daftarLaporan[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          laporan.id,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        Chip(
                          label: Text(
                            laporan.status,
                            style: const TextStyle(fontSize: 12),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                    Text(
                      laporan.judul,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      laporan.lokasi,
                      style: const TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            context.read<LaporanCubit>().tambahDukungan(
                              laporan.id,
                            );
                          },
                          icon: const Icon(Icons.thumb_up, size: 16),
                          label: Text('Dukung (${laporan.jumlahDukungan})'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.detailLaporan,
                              arguments: laporan.id,
                            );
                          },
                          child: const Text('Lihat Detail'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
