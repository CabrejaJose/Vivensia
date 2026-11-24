import 'dart:async';
import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/profile_repository.dart';

/// Perfil en `public.profiles`. RLS limita lectura/edición al propio perfil
/// (y lectura a integrantes de sus hogares).
class SupabaseProfileRepository implements ProfileRepository {
  SupabaseProfileRepository(this._client);

  final SupabaseClient _client;

  static const _columns = 'id, display_name, locale';

  String get _userId {
    final id = _client.auth.currentUser?.id;
    if (id == null) throw ProfileFailure.notFound;
    return id;
  }

  static UserProfile _fromRow(Map<String, dynamic> row) => UserProfile(
    id: row['id'] as String,
    displayName: row['display_name'] as String?,
    locale: row['locale'] as String? ?? 'es',
  );

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on ProfileFailure {
      rethrow;
    } on PostgrestException catch (e) {
      // PGRST116: la consulta `.single()` no devolvió filas.
      throw e.code == 'PGRST116'
          ? ProfileFailure.notFound
          : ProfileFailure.unexpected;
    } on SocketException {
      throw ProfileFailure.network;
    } on TimeoutException {
      throw ProfileFailure.network;
    } catch (_) {
      throw ProfileFailure.unexpected;
    }
  }

  @override
  Future<UserProfile> fetchMyProfile() => _guard(() async {
    final row = await _client
        .from('profiles')
        .select(_columns)
        .eq('id', _userId)
        .single();
    return _fromRow(row);
  });

  @override
  Future<UserProfile> updateMyProfile({String? displayName, String? locale}) =>
      _guard(() async {
        final changes = <String, Object>{
          if (displayName != null) 'display_name': displayName.trim(),
          'locale': ?locale,
        };
        final row = await _client
            .from('profiles')
            .update(changes)
            .eq('id', _userId)
            .select(_columns)
            .single();
        return _fromRow(row);
      });
}
