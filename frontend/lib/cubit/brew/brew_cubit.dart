import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../models/brew.dart';
import '../../services/api_service.dart';
import 'brew_state.dart';

class BrewCubit extends Cubit<BrewState> {
  final ApiService apiService;

  BrewCubit({required this.apiService}) : super(BrewInitial());

  // Fetch all brews
  Future<void> loadBrews() async {
    emit(BrewLoading());
    try {
      final brews = await apiService.fetchBrews();
      emit(BrewLoaded(brews));
    } catch (e) {
      emit(BrewError(e.toString()));
    }
  }

  // Create a new brew record and refresh the list
  Future<void> addBrew(Map<String, dynamic> brewData) async {
    emit(BrewLoading());
    try {
      await apiService.createBrew(brewData);
      await loadBrews();
    } catch (e) {
      emit(BrewError('Failed to create brew: ${e.toString()}'));
    }
  }

  // Update an existing brew
  Future<void> updateBrew(int id, Map<String, dynamic> brewData) async {
    emit(BrewLoading());
    try {
      await apiService.updateBrew(id, brewData);
      await loadBrews();
    } catch (e) {
      emit(BrewError('Failed to update brew: ${e.toString()}'));
    }
  } 

  // Delete a brew record and refresh the list
  Future<void> deleteBrew(int id) async {
    emit(BrewLoading());
    try {
      await apiService.deleteBrew(id);
      await loadBrews();
    } catch (e) {
      emit(BrewError('Failed to delete brew: ${e.toString()}'));
    }
  }
}
