import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritCubit extends Cubit<List<String>> {
  FavoritCubit() : super([]);

  void tandai(String namaLayanan) {
    if (!state.contains(namaLayanan)) {
      emit(List<String>.from(state)..add(namaLayanan));
    }
  }

  void batalTandai(String namaLayanan) {
    emit(state.where((item) => item != namaLayanan).toList());
  }
}
