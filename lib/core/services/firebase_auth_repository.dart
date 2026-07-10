import 'dart:async';

import 'package:arctive/core/models/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

import 'auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository({
    fb.FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
  })  : _firebaseAuth = firebaseAuth ?? fb.FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance {
    _authSub = _firebaseAuth.authStateChanges().listen(_onAuthChanged);
  }

  final fb.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final _controller = StreamController<AppUser?>.broadcast();

  AppUser? _latest;
  UserRole? _debugRoleOverride;
  StreamSubscription<fb.User?>? _authSub;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _userDocSub;

  void _onAuthChanged(fb.User? firebaseUser) {
    _userDocSub?.cancel();
    _debugRoleOverride = null;

    if (firebaseUser == null) {
      _latest = null;
      _controller.add(null);
      return;
    }

    _userDocSub = _firestore
        .collection('users')
        .doc(firebaseUser.uid)
        .snapshots()
        .listen((snapshot) {
      if (!snapshot.exists) {
        // Brief window right after signup, before the doc write lands.
        return;
      }
      final data = snapshot.data()!;
      var user = AppUser.fromJson({'id': firebaseUser.uid, ...data});
      if (_debugRoleOverride != null) {
        user = user.copyWith(
          role: _debugRoleOverride!,
          allowedSectors: _debugRoleOverride!.defaultAllowedSectors,
        );
      }
      _latest = user;
      _controller.add(user);
    });
  }

  @override
  Stream<AppUser?> get currentUser => _controller.stream;

  @override
  AppUser? get currentUserSnapshot => _latest;

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final uid = credential.user!.uid;
    await _firestore.collection('users').doc(uid).set({
      'name': name,
      'email': email,
      'role': UserRole.viewer.name,
      'allowedSectors':
          UserRole.viewer.defaultAllowedSectors.map((s) => s.name).toList(),
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> signIn(UserRole role) async {
    // Debug-only: locally overrides the role of whoever is actually signed
    // in, for quick permission-UI testing. Never touches Firestore/Auth.
    _debugRoleOverride = role;
    if (_latest != null) {
      final overridden = _latest!.copyWith(
        role: role,
        allowedSectors: role.defaultAllowedSectors,
      );
      _latest = overridden;
      _controller.add(overridden);
    }
  }

  @override
  Future<void> signOut() async {
    _debugRoleOverride = null;
    await _firebaseAuth.signOut();
  }

  Future<void> dispose() async {
    await _authSub?.cancel();
    await _userDocSub?.cancel();
    await _controller.close();
  }
}