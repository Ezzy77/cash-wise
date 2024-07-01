import 'package:cash_wise2/model/profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ProfileRepo {
  Future<Profile> getProfile(String userId);
  Future<void> updateProfile(Profile profile, String userId);
  Future<void> deleteProfile(String userId);
}

class ProfileRepoImpl extends ProfileRepo {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  @override
  Future<Profile> getProfile(String userId) async {

    // Get profile from supabase
    final response = await _supabaseClient
        .from('profiles')
        .select()
        .eq('id', userId);

    return Profile.fromMap(response[0]);
}

  @override
  Future<void> updateProfile(Profile profile, String userId) async {
    // Update profile in supabase
    await _supabaseClient
        .from('profiles')
        .upsert(profile.toMap())
        .eq('id', userId);
  }

  @override
  Future<void> deleteProfile(String userId) async {
    // Delete profile from supabase
    await _supabaseClient
        .from('profiles')
        .delete()
        .eq('id', userId);

  }
}