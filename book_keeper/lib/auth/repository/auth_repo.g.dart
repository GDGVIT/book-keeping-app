// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authStatusChangesHash() => r'08022849f245e0abcfa49e1263dff0834c9038c1';

/// See also [authStatusChanges].
@ProviderFor(authStatusChanges)
final authStatusChangesProvider = AutoDisposeStreamProvider<User?>.internal(
  authStatusChanges,
  name: r'authStatusChangesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authStatusChangesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthStatusChangesRef = AutoDisposeStreamProviderRef<User?>;
String _$customAuthRepoHash() => r'9b0b4fe6d2dbc79f0bf41f27bd59834b625ed4d2';

/// See also [customAuthRepo].
@ProviderFor(customAuthRepo)
final customAuthRepoProvider = AutoDisposeProvider<CustomAuth>.internal(
  customAuthRepo,
  name: r'customAuthRepoProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$customAuthRepoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CustomAuthRepoRef = AutoDisposeProviderRef<CustomAuth>;
String _$firebaseAuthRepoHash() => r'c36369b073779878288014b36b76be33d91d31a3';

/// See also [firebaseAuthRepo].
@ProviderFor(firebaseAuthRepo)
final firebaseAuthRepoProvider = AutoDisposeProvider<FireAuthRepo>.internal(
  firebaseAuthRepo,
  name: r'firebaseAuthRepoProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$firebaseAuthRepoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FirebaseAuthRepoRef = AutoDisposeProviderRef<FireAuthRepo>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
