// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'document.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DocumentTimelineEntry _$DocumentTimelineEntryFromJson(
  Map<String, dynamic> json,
) {
  return _DocumentTimelineEntry.fromJson(json);
}

/// @nodoc
mixin _$DocumentTimelineEntry {
  String get title => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;

  /// Serializes this DocumentTimelineEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DocumentTimelineEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DocumentTimelineEntryCopyWith<DocumentTimelineEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentTimelineEntryCopyWith<$Res> {
  factory $DocumentTimelineEntryCopyWith(
    DocumentTimelineEntry value,
    $Res Function(DocumentTimelineEntry) then,
  ) = _$DocumentTimelineEntryCopyWithImpl<$Res, DocumentTimelineEntry>;
  @useResult
  $Res call({String title, DateTime date});
}

/// @nodoc
class _$DocumentTimelineEntryCopyWithImpl<
  $Res,
  $Val extends DocumentTimelineEntry
>
    implements $DocumentTimelineEntryCopyWith<$Res> {
  _$DocumentTimelineEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DocumentTimelineEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? title = null, Object? date = null}) {
    return _then(
      _value.copyWith(
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DocumentTimelineEntryImplCopyWith<$Res>
    implements $DocumentTimelineEntryCopyWith<$Res> {
  factory _$$DocumentTimelineEntryImplCopyWith(
    _$DocumentTimelineEntryImpl value,
    $Res Function(_$DocumentTimelineEntryImpl) then,
  ) = __$$DocumentTimelineEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, DateTime date});
}

/// @nodoc
class __$$DocumentTimelineEntryImplCopyWithImpl<$Res>
    extends
        _$DocumentTimelineEntryCopyWithImpl<$Res, _$DocumentTimelineEntryImpl>
    implements _$$DocumentTimelineEntryImplCopyWith<$Res> {
  __$$DocumentTimelineEntryImplCopyWithImpl(
    _$DocumentTimelineEntryImpl _value,
    $Res Function(_$DocumentTimelineEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DocumentTimelineEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? title = null, Object? date = null}) {
    return _then(
      _$DocumentTimelineEntryImpl(
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DocumentTimelineEntryImpl implements _DocumentTimelineEntry {
  const _$DocumentTimelineEntryImpl({required this.title, required this.date});

  factory _$DocumentTimelineEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$DocumentTimelineEntryImplFromJson(json);

  @override
  final String title;
  @override
  final DateTime date;

  @override
  String toString() {
    return 'DocumentTimelineEntry(title: $title, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentTimelineEntryImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, date);

  /// Create a copy of DocumentTimelineEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DocumentTimelineEntryImplCopyWith<_$DocumentTimelineEntryImpl>
  get copyWith =>
      __$$DocumentTimelineEntryImplCopyWithImpl<_$DocumentTimelineEntryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DocumentTimelineEntryImplToJson(this);
  }
}

abstract class _DocumentTimelineEntry implements DocumentTimelineEntry {
  const factory _DocumentTimelineEntry({
    required final String title,
    required final DateTime date,
  }) = _$DocumentTimelineEntryImpl;

  factory _DocumentTimelineEntry.fromJson(Map<String, dynamic> json) =
      _$DocumentTimelineEntryImpl.fromJson;

  @override
  String get title;
  @override
  DateTime get date;

  /// Create a copy of DocumentTimelineEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DocumentTimelineEntryImplCopyWith<_$DocumentTimelineEntryImpl>
  get copyWith => throw _privateConstructorUsedError;
}

Document _$DocumentFromJson(Map<String, dynamic> json) {
  return _Document.fromJson(json);
}

/// @nodoc
mixin _$Document {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  DocumentSector get sector => throw _privateConstructorUsedError;
  DateTime get dateCreated => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  String get ocrText => throw _privateConstructorUsedError;
  String get aiSummary => throw _privateConstructorUsedError;
  Map<String, String> get aiFields => throw _privateConstructorUsedError;
  List<DocumentTimelineEntry> get timeline =>
      throw _privateConstructorUsedError;
  List<String> get risks => throw _privateConstructorUsedError;
  int get completenessScore => throw _privateConstructorUsedError;
  String get iconEmoji => throw _privateConstructorUsedError;
  String get colorHex => throw _privateConstructorUsedError;

  /// Serializes this Document to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Document
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DocumentCopyWith<Document> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentCopyWith<$Res> {
  factory $DocumentCopyWith(Document value, $Res Function(Document) then) =
      _$DocumentCopyWithImpl<$Res, Document>;
  @useResult
  $Res call({
    String id,
    String title,
    DocumentSector sector,
    DateTime dateCreated,
    String description,
    List<String> tags,
    String ocrText,
    String aiSummary,
    Map<String, String> aiFields,
    List<DocumentTimelineEntry> timeline,
    List<String> risks,
    int completenessScore,
    String iconEmoji,
    String colorHex,
  });
}

/// @nodoc
class _$DocumentCopyWithImpl<$Res, $Val extends Document>
    implements $DocumentCopyWith<$Res> {
  _$DocumentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Document
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? sector = null,
    Object? dateCreated = null,
    Object? description = null,
    Object? tags = null,
    Object? ocrText = null,
    Object? aiSummary = null,
    Object? aiFields = null,
    Object? timeline = null,
    Object? risks = null,
    Object? completenessScore = null,
    Object? iconEmoji = null,
    Object? colorHex = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            sector: null == sector
                ? _value.sector
                : sector // ignore: cast_nullable_to_non_nullable
                      as DocumentSector,
            dateCreated: null == dateCreated
                ? _value.dateCreated
                : dateCreated // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            ocrText: null == ocrText
                ? _value.ocrText
                : ocrText // ignore: cast_nullable_to_non_nullable
                      as String,
            aiSummary: null == aiSummary
                ? _value.aiSummary
                : aiSummary // ignore: cast_nullable_to_non_nullable
                      as String,
            aiFields: null == aiFields
                ? _value.aiFields
                : aiFields // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>,
            timeline: null == timeline
                ? _value.timeline
                : timeline // ignore: cast_nullable_to_non_nullable
                      as List<DocumentTimelineEntry>,
            risks: null == risks
                ? _value.risks
                : risks // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            completenessScore: null == completenessScore
                ? _value.completenessScore
                : completenessScore // ignore: cast_nullable_to_non_nullable
                      as int,
            iconEmoji: null == iconEmoji
                ? _value.iconEmoji
                : iconEmoji // ignore: cast_nullable_to_non_nullable
                      as String,
            colorHex: null == colorHex
                ? _value.colorHex
                : colorHex // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DocumentImplCopyWith<$Res>
    implements $DocumentCopyWith<$Res> {
  factory _$$DocumentImplCopyWith(
    _$DocumentImpl value,
    $Res Function(_$DocumentImpl) then,
  ) = __$$DocumentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    DocumentSector sector,
    DateTime dateCreated,
    String description,
    List<String> tags,
    String ocrText,
    String aiSummary,
    Map<String, String> aiFields,
    List<DocumentTimelineEntry> timeline,
    List<String> risks,
    int completenessScore,
    String iconEmoji,
    String colorHex,
  });
}

/// @nodoc
class __$$DocumentImplCopyWithImpl<$Res>
    extends _$DocumentCopyWithImpl<$Res, _$DocumentImpl>
    implements _$$DocumentImplCopyWith<$Res> {
  __$$DocumentImplCopyWithImpl(
    _$DocumentImpl _value,
    $Res Function(_$DocumentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Document
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? sector = null,
    Object? dateCreated = null,
    Object? description = null,
    Object? tags = null,
    Object? ocrText = null,
    Object? aiSummary = null,
    Object? aiFields = null,
    Object? timeline = null,
    Object? risks = null,
    Object? completenessScore = null,
    Object? iconEmoji = null,
    Object? colorHex = null,
  }) {
    return _then(
      _$DocumentImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        sector: null == sector
            ? _value.sector
            : sector // ignore: cast_nullable_to_non_nullable
                  as DocumentSector,
        dateCreated: null == dateCreated
            ? _value.dateCreated
            : dateCreated // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        ocrText: null == ocrText
            ? _value.ocrText
            : ocrText // ignore: cast_nullable_to_non_nullable
                  as String,
        aiSummary: null == aiSummary
            ? _value.aiSummary
            : aiSummary // ignore: cast_nullable_to_non_nullable
                  as String,
        aiFields: null == aiFields
            ? _value._aiFields
            : aiFields // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>,
        timeline: null == timeline
            ? _value._timeline
            : timeline // ignore: cast_nullable_to_non_nullable
                  as List<DocumentTimelineEntry>,
        risks: null == risks
            ? _value._risks
            : risks // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        completenessScore: null == completenessScore
            ? _value.completenessScore
            : completenessScore // ignore: cast_nullable_to_non_nullable
                  as int,
        iconEmoji: null == iconEmoji
            ? _value.iconEmoji
            : iconEmoji // ignore: cast_nullable_to_non_nullable
                  as String,
        colorHex: null == colorHex
            ? _value.colorHex
            : colorHex // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DocumentImpl implements _Document {
  const _$DocumentImpl({
    required this.id,
    required this.title,
    required this.sector,
    required this.dateCreated,
    required this.description,
    required final List<String> tags,
    required this.ocrText,
    required this.aiSummary,
    required final Map<String, String> aiFields,
    required final List<DocumentTimelineEntry> timeline,
    required final List<String> risks,
    this.completenessScore = 0,
    required this.iconEmoji,
    required this.colorHex,
  }) : _tags = tags,
       _aiFields = aiFields,
       _timeline = timeline,
       _risks = risks;

  factory _$DocumentImpl.fromJson(Map<String, dynamic> json) =>
      _$$DocumentImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final DocumentSector sector;
  @override
  final DateTime dateCreated;
  @override
  final String description;
  final List<String> _tags;
  @override
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final String ocrText;
  @override
  final String aiSummary;
  final Map<String, String> _aiFields;
  @override
  Map<String, String> get aiFields {
    if (_aiFields is EqualUnmodifiableMapView) return _aiFields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_aiFields);
  }

  final List<DocumentTimelineEntry> _timeline;
  @override
  List<DocumentTimelineEntry> get timeline {
    if (_timeline is EqualUnmodifiableListView) return _timeline;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_timeline);
  }

  final List<String> _risks;
  @override
  List<String> get risks {
    if (_risks is EqualUnmodifiableListView) return _risks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_risks);
  }

  @override
  @JsonKey()
  final int completenessScore;
  @override
  final String iconEmoji;
  @override
  final String colorHex;

  @override
  String toString() {
    return 'Document(id: $id, title: $title, sector: $sector, dateCreated: $dateCreated, description: $description, tags: $tags, ocrText: $ocrText, aiSummary: $aiSummary, aiFields: $aiFields, timeline: $timeline, risks: $risks, completenessScore: $completenessScore, iconEmoji: $iconEmoji, colorHex: $colorHex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.sector, sector) || other.sector == sector) &&
            (identical(other.dateCreated, dateCreated) ||
                other.dateCreated == dateCreated) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.ocrText, ocrText) || other.ocrText == ocrText) &&
            (identical(other.aiSummary, aiSummary) ||
                other.aiSummary == aiSummary) &&
            const DeepCollectionEquality().equals(other._aiFields, _aiFields) &&
            const DeepCollectionEquality().equals(other._timeline, _timeline) &&
            const DeepCollectionEquality().equals(other._risks, _risks) &&
            (identical(other.completenessScore, completenessScore) ||
                other.completenessScore == completenessScore) &&
            (identical(other.iconEmoji, iconEmoji) ||
                other.iconEmoji == iconEmoji) &&
            (identical(other.colorHex, colorHex) ||
                other.colorHex == colorHex));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    sector,
    dateCreated,
    description,
    const DeepCollectionEquality().hash(_tags),
    ocrText,
    aiSummary,
    const DeepCollectionEquality().hash(_aiFields),
    const DeepCollectionEquality().hash(_timeline),
    const DeepCollectionEquality().hash(_risks),
    completenessScore,
    iconEmoji,
    colorHex,
  );

  /// Create a copy of Document
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DocumentImplCopyWith<_$DocumentImpl> get copyWith =>
      __$$DocumentImplCopyWithImpl<_$DocumentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DocumentImplToJson(this);
  }
}

abstract class _Document implements Document {
  const factory _Document({
    required final String id,
    required final String title,
    required final DocumentSector sector,
    required final DateTime dateCreated,
    required final String description,
    required final List<String> tags,
    required final String ocrText,
    required final String aiSummary,
    required final Map<String, String> aiFields,
    required final List<DocumentTimelineEntry> timeline,
    required final List<String> risks,
    final int completenessScore,
    required final String iconEmoji,
    required final String colorHex,
  }) = _$DocumentImpl;

  factory _Document.fromJson(Map<String, dynamic> json) =
      _$DocumentImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  DocumentSector get sector;
  @override
  DateTime get dateCreated;
  @override
  String get description;
  @override
  List<String> get tags;
  @override
  String get ocrText;
  @override
  String get aiSummary;
  @override
  Map<String, String> get aiFields;
  @override
  List<DocumentTimelineEntry> get timeline;
  @override
  List<String> get risks;
  @override
  int get completenessScore;
  @override
  String get iconEmoji;
  @override
  String get colorHex;

  /// Create a copy of Document
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DocumentImplCopyWith<_$DocumentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
