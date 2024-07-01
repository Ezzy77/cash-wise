import 'package:cash_wise2/repository/profile_repo.dart';
import '../model/profile.dart';

class ProfileService {
  final ProfileRepo _profileRepository = ProfileRepoImpl();

  Future<Profile> getProfile(String userId) async {
    return _profileRepository.getProfile(userId);
  }

  Future<void> updateProfile(Profile profile, String userId) async {
    return _profileRepository.updateProfile(profile, userId);
  }

  Future<void> deleteProfile(String userId) async {
    return _profileRepository.deleteProfile(userId);
  }
}
