import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_challenge/services/profie_service.dart';


class ProfileCubit extends Cubit<ProfileState> {
  final ProfileService profileService;

  ProfileCubit({required this.profileService}) : super(ProfileInitial());

  Future<void> submitProfile(Map<String, dynamic> profileData) async {
    emit(ProfileLoading());
    try {
      final id = await profileService.saveProfile(profileData);
      emit(ProfileSuccess(id: id.toString()));
    } catch (e) {
      emit(ProfileError(error: e.toString()));
    }
  }
}


abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final String id;
  ProfileSuccess({required this.id});
}

class ProfileEmpty extends ProfileState {}

class ProfileError extends ProfileState {
  final String error;
  ProfileError({required this.error});
}
