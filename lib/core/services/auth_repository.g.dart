// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authRepositoryHash() => r'41f9736cc6b137f39a6ba2fb1e4c0ce83f6c8e8d';

/// See also [authRepository].
@ProviderFor(authRepository)
final authRepositoryProvider = Provider<AuthRepository>.internal(
  authRepository,
  name: r'authRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthRepositoryRef = ProviderRef<AuthRepository>;
String _$currentAppUserHash() => r'81d36bf912f5241893d805c08a34e0d208c7d7c0';

/// See also [CurrentAppUser].
@ProviderFor(CurrentAppUser)
final currentAppUserProvider =
    NotifierProvider<CurrentAppUser, AppUser?>.internal(
      CurrentAppUser.new,
      name: r'currentAppUserProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$currentAppUserHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CurrentAppUser = Notifier<AppUser?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
