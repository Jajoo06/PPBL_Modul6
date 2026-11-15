import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/pengajuan_cubit.dart';

class HalamanDetailLayanan extends StatefulWidget {
  final String namaLayanan;

  const HalamanDetailLayanan({super.key, required this.namaLayanan});

  @override
  State<HalamanDetailLayanan> createState() => _HalamanDetailLayananState();
}

class _HalamanDetailLayananState extends State<HalamanDetailLayanan> {
  bool _isSubmitting = false;

  void _ajukanPermohonan() async {
    setState(() {
      _isSubmitting = true;
    });

    // Indikator loading singkat
    await Future.delayed(const Duration(milliseconds: 1000));

    if (!mounted) return;

    context.read<PengajuanCubit>().tambahPengajuan(widget.namaLayanan);

    setState(() {
      _isSubmitting = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${widget.namaLayanan} berhasil diajukan')),
    );

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(widget.namaLayanan)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rincian Layanan:',
              style: textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              widget.namaLayanan,
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Silakan periksa data sebelum mengajukan permohonan ke dinas terkait. Permohonan akan dicatat ke keranjang pengajuan Anda.',
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                ),
                onPressed: _isSubmitting ? null : _ajukanPermohonan,
                child: _isSubmitting
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: colorScheme.onPrimary,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text('Sedang Mengirim...'),
                        ],
                      )
                    : const Text(
                        'Ajukan Permohonan',
                        style: TextStyle(fontSize: 16),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}