// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DocumentTimelineEntryImpl _$$DocumentTimelineEntryImplFromJson(
  Map<String, dynamic> json,
) => _$DocumentTimelineEntryImpl(
  title: json['title'] as String,
  date: DateTime.parse(json['date'] as String),
);

Map<String, dynamic> _$$DocumentTimelineEntryImplToJson(
  _$DocumentTimelineEntryImpl instance,
) => <String, dynamic>{
  'title': instance.title,
  'date': instance.date.toIso8601String(),
};

_$DocumentImpl _$$DocumentImplFromJson(Map<String, dynamic> json) =>
    _$DocumentImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      sector: $enumDecode(_$DocumentSectorEnumMap, json['sector']),
      dateCreated: DateTime.parse(json['dateCreated'] as String),
      description: json['description'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      ocrText: json['ocrText'] as String,
      aiSummary: json['aiSummary'] as String,
      aiFields: Map<String, String>.from(json['aiFields'] as Map),
      timeline: (json['timeline'] as List<dynamic>)
          .map((e) => DocumentTimelineEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      risks: (json['risks'] as List<dynamic>).map((e) => e as String).toList(),
      completenessScore: (json['completenessScore'] as num?)?.toInt() ?? 0,
      iconEmoji: json['iconEmoji'] as String,
      colorHex: json['colorHex'] as String,
    );

Map<String, dynamic> _$$DocumentImplToJson(_$DocumentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'sector': _$DocumentSectorEnumMap[instance.sector]!,
      'dateCreated': instance.dateCreated.toIso8601String(),
      'description': instance.description,
      'tags': instance.tags,
      'ocrText': instance.ocrText,
      'aiSummary': instance.aiSummary,
      'aiFields': instance.aiFields,
      'timeline': instance.timeline,
      'risks': instance.risks,
      'completenessScore': instance.completenessScore,
      'iconEmoji': instance.iconEmoji,
      'colorHex': instance.colorHex,
    };

const _$DocumentSectorEnumMap = {
  DocumentSector.realEstate: 'realEstate',
  DocumentSector.legal: 'legal',
  DocumentSector.medical: 'medical',
  DocumentSector.engineering: 'engineering',
};
