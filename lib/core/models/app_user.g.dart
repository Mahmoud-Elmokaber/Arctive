// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppUserImpl _$$AppUserImplFromJson(Map<String, dynamic> json) =>
    _$AppUserImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: $enumDecode(_$UserRoleEnumMap, json['role']),
      allowedSectors:
          (json['allowedSectors'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$DocumentSectorEnumMap, e))
              .toList() ??
          const <DocumentSector>[],
    );

Map<String, dynamic> _$$AppUserImplToJson(_$AppUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'role': _$UserRoleEnumMap[instance.role]!,
      'allowedSectors': instance.allowedSectors
          .map((e) => _$DocumentSectorEnumMap[e]!)
          .toList(),
    };

const _$UserRoleEnumMap = {
  UserRole.superAdmin: 'superAdmin',
  UserRole.admin: 'admin',
  UserRole.analyst: 'analyst',
  UserRole.viewer: 'viewer',
  UserRole.scanner: 'scanner',
};

const _$DocumentSectorEnumMap = {
  DocumentSector.realEstate: 'realEstate',
  DocumentSector.legal: 'legal',
  DocumentSector.medical: 'medical',
  DocumentSector.engineering: 'engineering',
};
