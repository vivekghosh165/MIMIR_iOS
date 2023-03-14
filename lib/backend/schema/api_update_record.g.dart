// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_update_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ApiUpdateRecord> _$apiUpdateRecordSerializer =
    new _$ApiUpdateRecordSerializer();

class _$ApiUpdateRecordSerializer
    implements StructuredSerializer<ApiUpdateRecord> {
  @override
  final Iterable<Type> types = const [ApiUpdateRecord, _$ApiUpdateRecord];
  @override
  final String wireName = 'ApiUpdateRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, ApiUpdateRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    value = object.rollNo;
    if (value != null) {
      result
        ..add('rollNo')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(int)])));
    }
    value = object.ffRef;
    if (value != null) {
      result
        ..add('Document__Reference__Field')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    return result;
  }

  @override
  ApiUpdateRecord deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ApiUpdateRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'name':
          result.name.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'rollNo':
          result.rollNo.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(int)]))!
              as BuiltList<Object?>);
          break;
        case 'Document__Reference__Field':
          result.ffRef = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
      }
    }

    return result.build();
  }
}

class _$ApiUpdateRecord extends ApiUpdateRecord {
  @override
  final BuiltList<String>? name;
  @override
  final BuiltList<int>? rollNo;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$ApiUpdateRecord([void Function(ApiUpdateRecordBuilder)? updates]) =>
      (new ApiUpdateRecordBuilder()..update(updates))._build();

  _$ApiUpdateRecord._({this.name, this.rollNo, this.ffRef}) : super._();

  @override
  ApiUpdateRecord rebuild(void Function(ApiUpdateRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ApiUpdateRecordBuilder toBuilder() =>
      new ApiUpdateRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiUpdateRecord &&
        name == other.name &&
        rollNo == other.rollNo &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, name.hashCode), rollNo.hashCode), ffRef.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ApiUpdateRecord')
          ..add('name', name)
          ..add('rollNo', rollNo)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class ApiUpdateRecordBuilder
    implements Builder<ApiUpdateRecord, ApiUpdateRecordBuilder> {
  _$ApiUpdateRecord? _$v;

  ListBuilder<String>? _name;
  ListBuilder<String> get name => _$this._name ??= new ListBuilder<String>();
  set name(ListBuilder<String>? name) => _$this._name = name;

  ListBuilder<int>? _rollNo;
  ListBuilder<int> get rollNo => _$this._rollNo ??= new ListBuilder<int>();
  set rollNo(ListBuilder<int>? rollNo) => _$this._rollNo = rollNo;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  ApiUpdateRecordBuilder() {
    ApiUpdateRecord._initializeBuilder(this);
  }

  ApiUpdateRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name?.toBuilder();
      _rollNo = $v.rollNo?.toBuilder();
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApiUpdateRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ApiUpdateRecord;
  }

  @override
  void update(void Function(ApiUpdateRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ApiUpdateRecord build() => _build();

  _$ApiUpdateRecord _build() {
    _$ApiUpdateRecord _$result;
    try {
      _$result = _$v ??
          new _$ApiUpdateRecord._(
              name: _name?.build(), rollNo: _rollNo?.build(), ffRef: ffRef);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'name';
        _name?.build();
        _$failedField = 'rollNo';
        _rollNo?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ApiUpdateRecord', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
