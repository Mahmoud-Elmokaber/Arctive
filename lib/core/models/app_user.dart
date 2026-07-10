import 'package:arctive/core/models/document.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

enum UserRole { superAdmin, admin, analyst, viewer, scanner }

extension UserRolePermissions on UserRole {
  bool get canReadDocuments => this != UserRole.scanner;

  bool get canUploadDocuments =>
      this == UserRole.superAdmin ||
      this == UserRole.admin ||
      this == UserRole.scanner;

  bool get canEditDocuments =>
      this == UserRole.superAdmin || this == UserRole.admin;

  bool get canDeleteDocuments => this == UserRole.superAdmin;

  bool get canManageUsers => this == UserRole.superAdmin;

  bool get canChangeSystemSettings => this == UserRole.superAdmin;

  bool get canRunAiAnalysis =>
      this == UserRole.superAdmin ||
      this == UserRole.admin ||
      this == UserRole.analyst;

  bool get canExport =>
      this == UserRole.superAdmin ||
      this == UserRole.admin ||
      this == UserRole.analyst;

  bool get canOpenScan =>
      this == UserRole.superAdmin ||
      this == UserRole.admin ||
      this == UserRole.scanner;

  List<DocumentSector> get defaultAllowedSectors => switch (this) {
    UserRole.scanner => const <DocumentSector>[],
    _ => DocumentSector.values,
  };
}

@freezed
class AppUser with _$AppUser {
  const factory AppUser({
    required String id,
    required String name,
    required String email,
    required UserRole role,
    @Default(<DocumentSector>[]) List<DocumentSector> allowedSectors,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}
