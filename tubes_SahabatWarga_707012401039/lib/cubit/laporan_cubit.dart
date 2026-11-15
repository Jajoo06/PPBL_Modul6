import 'package:flutter_bloc/flutter_bloc.dart';

class ItemLaporan {
  final String id;
  final String judul;
  final String lokasi;
  final String status; // 'Menunggu', 'Diproses', 'Selesai'
  final int jumlahDukungan;

  const ItemLaporan({
    required this.id,
    required this.judul,
    required this.lokasi,
    required this.status,
    this.jumlahDukungan = 0,
  });

  ItemLaporan copyWith({
    String? id,
    String? judul,
    String? lokasi,
    String? status,
    int? jumlahDukungan,
  }) {
    return ItemLaporan(
      id: id ?? this.id,
      judul: judul ?? this.judul,
      lokasi: lokasi ?? this.lokasi,
      status: status ?? this.status,
      jumlahDukungan: jumlahDukungan ?? this.jumlahDukungan,
    );
  }
}

class LaporanCubit extends Cubit<List<ItemLaporan>> {
  LaporanCubit()
    : super([
        const ItemLaporan(
          id: 'LAP-001',
          judul: 'Lampu Penerangan Jalan Padam',
          lokasi: 'Jl. Merdeka No. 12',
          status: 'Diproses',
          jumlahDukungan: 5,
        ),
        const ItemLaporan(
          id: 'LAP-002',
          judul: 'Saluran Air Tersumbat Sampah',
          lokasi: 'Gang Mawar RT 03',
          status: 'Menunggu',
          jumlahDukungan: 12,
        ),
        const ItemLaporan(
          id: 'LAP-003',
          judul: 'Jalan Berlubang Dekat Gapura',
          lokasi: 'Jl. Pemuda RW 05',
          status: 'Menunggu',
          jumlahDukungan: 8,
        ),
      ]);

  // Aksi bersama: Tambah dukungan/tanda tangan warga
  void tambahDukungan(String id) {
    emit(
      state.map((laporan) {
        if (laporan.id == id) {
          return laporan.copyWith(jumlahDukungan: laporan.jumlahDukungan + 1);
        }
        return laporan;
      }).toList(),
    );
  }

  // Aksi bersama: Perbarui status laporan
  void perbaruiStatus(String id, String statusBaru) {
    emit(
      state.map((laporan) {
        if (laporan.id == id) {
          return laporan.copyWith(status: statusBaru);
        }
        return laporan;
      }).toList(),
    );
  }
}
