import 'package:flutter/material.dart';

import 'kerangka_navigasi.dart';
import '../pages/halaman_detail_layanan.dart';
import '../pages/halaman_riwayat_laporan.dart';
import '../pages/halaman_pengaturan_kota.dart';
import '../pages/halaman_tentang_aplikasi.dart';
import '../pages/halaman_keluar.dart';
import '../pages/halaman_route_tidak_dikenal.dart';

class AppRoutes {
  static const String beranda = '/';
  static const String detailLayanan = '/detail-layanan';
  static const String riwayatLaporan = '/riwayat-laporan';
  static const String pengaturanKota = '/pengaturan-kota';
  static const String tentangAplikasi = '/tentang-aplikasi';
  static const String keluar = '/keluar';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case beranda:
        return MaterialPageRoute(builder: (_) => const KerangkaNavigasi());
      case detailLayanan:
        final namaLayanan = settings.arguments as String? ?? 'Detail Layanan';
        return MaterialPageRoute(
          builder: (_) => HalamanDetailLayanan(namaLayanan: namaLayanan),
          settings: settings,
        );
      case riwayatLaporan:
        return MaterialPageRoute(builder: (_) => const HalamanRiwayatLaporan());
      case pengaturanKota:
        return MaterialPageRoute(builder: (_) => const HalamanPengaturanKota());
      case tentangAplikasi:
        return MaterialPageRoute(
          builder: (_) => const HalamanTentangAplikasi(),
        );
      case keluar:
        return MaterialPageRoute(builder: (_) => const HalamanKeluar());
      default:
        return MaterialPageRoute(
          builder: (_) => HalamanRouteTidakDikenal(
            namaRoute: settings.name ?? 'Route Tidak Dikenal',
          ),
          settings: settings,
        );
    }
  }

  static Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => HalamanRouteTidakDikenal(
        namaRoute: settings.name ?? 'Route Tidak Dikenal',
      ),
      settings: settings,
    );
  }
}
