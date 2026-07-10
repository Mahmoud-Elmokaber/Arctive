import 'dart:async';

import 'package:arctive/core/models/app_user.dart';
import 'package:arctive/core/models/document.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'firebase_auth_repository.dart';

part 'auth_repository.g.dart';

abstract class AuthRepository {
  Stream<AppUser?> get currentUser;

  AppUser? get currentUserSnapshot;

  /// Debug-only role switch — see implementations for what this does.
  Future<void> signIn(UserRole role);

  Future<void> signInWithEmailAndPassword(String email, String password);

  Future<void> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<void> signOut();
}

class MockAuthRepository implements AuthRepository {
  MockAuthRepository() : _controller = StreamController<AppUser?>.broadcast();

  final StreamController<AppUser?> _controller;
  AppUser? _currentUser;

  @override
  Stream<AppUser?> get currentUser => _controller.stream;

  @override
  AppUser? get currentUserSnapshot => _currentUser;

  @override
  Future<void> signIn(UserRole role) async {
    final user = AppUser(
      id: 'local-${role.name}',
      name: switch (role) {
        UserRole.superAdmin => 'Super Admin',
        UserRole.admin => 'Admin',
        UserRole.analyst => 'Analyst',
        UserRole.viewer => 'Viewer',
        UserRole.scanner => 'Scanner',
      },
      email: '${role.name}@arctive.local',
      role: role,
      allowedSectors: role.defaultAllowedSectors,
    );

    _currentUser = user;
    _controller.add(user);
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) {
    throw UnimplementedError(
      'MockAuthRepository is debug-only — use signIn(role) instead.',
    );
  }

  @override
  Future<void> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) {
    throw UnimplementedError(
      'MockAuthRepository is debug-only — use signIn(role) instead.',
    );
  }

  @override
  Future<void> signOut() async {
    _currentUser = null;
    _controller.add(null);
  }

  Future<void> dispose() async {
    await _controller.close();
  }
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  final repository = FirebaseAuthRepository();
  ref.onDispose(repository.dispose);
  return repository;
}

@Riverpod(keepAlive: true)
class CurrentAppUser extends _$CurrentAppUser {
  @override
  AppUser? build() {
    final repository = ref.watch(authRepositoryProvider);

    final subscription = repository.currentUser.listen((user) {
      state = user;
    });
    ref.onDispose(subscription.cancel);

    return repository.currentUserSnapshot;
  }

  Future<void> signIn(UserRole role) =>
      ref.read(authRepositoryProvider).signIn(role);

  Future<void> signOut() => ref.read(authRepositoryProvider).signOut();

  Future<void> switchRole(UserRole role) => signIn(role);

  Future<void> signInWithEmail(String email, String password) => ref
      .read(authRepositoryProvider)
      .signInWithEmailAndPassword(email, password);

  Future<void> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  }) =>
      ref.read(authRepositoryProvider).signUpWithEmailAndPassword(
            name: name,
            email: email,
            password: password,
          );
}