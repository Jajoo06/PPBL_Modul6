import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/laporan_cubit.dart';

class HalamanDetailLaporan extends StatefulWidget {
  final String idLaporan;

  const HalamanDetailLaporan({super.key, required this.idLaporan});

  @override
  State<HalamanDetailLaporan> createState() => _HalamanDetailLaporanState();
}

class _HalamanDetailLaporanState extends State<HalamanDetailLaporan> {
  // 1. State Lokal: Status memuat / sedang memproses tanggapan
  bool _isLoading = false;

  void _prosesVerifikasi() async {
    setState(() {
      _isLoading = true;
    });

    // Simulasi jeda pengiriman data
    await Future.delayed(const Duration(milliseconds: 1000));

    if (!mounted) return;

    // 2. Memperbarui State Bersama (Cubit)
    context.read<LaporanCubit>().perbaruiStatus(widget.idLaporan, 'Selesai');

    setState(() {
      _isLoading = false;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Laporan ditandai Selesai')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail ${widget.idLaporan}')),
      body: BlocBuilder<LaporanCubit, List<ItemLaporan>>(
        builder: (context, list) {
          final laporan = list.firstWhere(
            (item) => item.id == widget.idLaporan,
            orElse: () => const ItemLaporan(
              id: '',
              judul: 'Tidak Ditemukan',
              lokasi: '-',
              status: '-',
            ),
          );

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  laporan.judul,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Lokasi: ${laporan.lokasi}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  'Status Terkini: ${laporan.status}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Text('Jumlah Dukungan Warga: ${laporan.jumlahDukungan} orang'),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _prosesVerifikasi,
                    child: _isLoading
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                              SizedBox(width: 12),
                              Text('Menyimpan Perubahan...'),
                            ],
                          )
                        : const Text('Tandai Sebagai Selesai'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
