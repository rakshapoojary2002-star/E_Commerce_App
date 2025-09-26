import 'package:flutter/material.dart';
import 'package:e_commerce_app/domain/profile/entities/user_profile.dart';
import 'package:e_commerce_app/domain/profile/repositories/profile_repository.dart';

enum ProfileState {
  initial,
  loading,
  loaded,
  error,
}

class ProfileProvider with ChangeNotifier {
  final ProfileRepository profileRepository;

  ProfileProvider({required this.profileRepository});

  UserProfile? _userProfile;
  UserProfile? get userProfile => _userProfile;

  ProfileState _state = ProfileState.initial;
  ProfileState get state => _state;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchUserProfile() async {
    _state = ProfileState.loading;
    notifyListeners();
    try {
      _userProfile = await profileRepository.getUserProfile();
      _state = ProfileState.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _state = ProfileState.error;
    }
    notifyListeners();
  }
}