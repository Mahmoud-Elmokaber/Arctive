import 'package:freezed_annotation/freezed_annotation.dart';

part 'document.freezed.dart';
part 'document.g.dart';

enum DocumentSector { realEstate, legal, medical, engineering }

@freezed
class DocumentTimelineEntry with _$DocumentTimelineEntry {
  const factory DocumentTimelineEntry({
    required String title,
    required DateTime date,
  }) = _DocumentTimelineEntry;

  factory DocumentTimelineEntry.fromJson(Map<String, dynamic> json) =>
      _$DocumentTimelineEntryFromJson(json);
}

@freezed
class Document with _$Document {
  const factory Document({
    required String id,
    required String title,
    required DocumentSector sector,
    required DateTime dateCreated,
    required String description,
    required List<String> tags,
    required String ocrText,
    required String aiSummary,
    required Map<String, String> aiFields,
    required List<DocumentTimelineEntry> timeline,
    required List<String> risks,
    @Default(0) int completenessScore,
    required String iconEmoji,
    required String colorHex,
  }) = _Document;

  factory Document.fromJson(Map<String, dynamic> json) =>
      _$DocumentFromJson(json);
}
