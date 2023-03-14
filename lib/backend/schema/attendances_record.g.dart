// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendances_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AttendancesRecord> _$attendancesRecordSerializer =
    new _$AttendancesRecordSerializer();

class _$AttendancesRecordSerializer
    implements StructuredSerializer<AttendancesRecord> {
  @override
  final Iterable<Type> types = const [AttendancesRecord, _$AttendancesRecord];
  @override
  final String wireName = 'AttendancesRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, AttendancesRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.studentName;
    if (value != null) {
      result
        ..add('studentName')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.studentEmail;
    if (value != null) {
      result
        ..add('studentEmail')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.attendanceTime;
    if (value != null) {
      result
        ..add('attendanceTime')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
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
  AttendancesRecord deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AttendancesRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'studentName':
          result.studentName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'studentEmail':
          result.studentEmail = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'attendanceTime':
          result.attendanceTime = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
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

class _$AttendancesRecord extends AttendancesRecord {
  @override
  final String? studentName;
  @override
  final String? studentEmail;
  @override
  final DateTime? attendanceTime;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$AttendancesRecord(
          [void Function(AttendancesRecordBuilder)? updates]) =>
      (new AttendancesRecordBuilder()..update(updates))._build();

  _$AttendancesRecord._(
      {this.studentName, this.studentEmail, this.attendanceTime, this.ffRef})
      : super._();

  @override
  AttendancesRecord rebuild(void Function(AttendancesRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AttendancesRecordBuilder toBuilder() =>
      new AttendancesRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AttendancesRecord &&
        studentName == other.studentName &&
        studentEmail == other.studentEmail &&
        attendanceTime == other.attendanceTime &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, studentName.hashCode), studentEmail.hashCode),
            attendanceTime.hashCode),
        ffRef.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AttendancesRecord')
          ..add('studentName', studentName)
          ..add('studentEmail', studentEmail)
          ..add('attendanceTime', attendanceTime)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class AttendancesRecordBuilder
    implements Builder<AttendancesRecord, AttendancesRecordBuilder> {
  _$AttendancesRecord? _$v;

  String? _studentName;
  String? get studentName => _$this._studentName;
  set studentName(String? studentName) => _$this._studentName = studentName;

  String? _studentEmail;
  String? get studentEmail => _$this._studentEmail;
  set studentEmail(String? studentEmail) => _$this._studentEmail = studentEmail;

  DateTime? _attendanceTime;
  DateTime? get attendanceTime => _$this._attendanceTime;
  set attendanceTime(DateTime? attendanceTime) =>
      _$this._attendanceTime = attendanceTime;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  AttendancesRecordBuilder() {
    AttendancesRecord._initializeBuilder(this);
  }

  AttendancesRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _studentName = $v.studentName;
      _studentEmail = $v.studentEmail;
      _attendanceTime = $v.attendanceTime;
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AttendancesRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AttendancesRecord;
  }

  @override
  void update(void Function(AttendancesRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AttendancesRecord build() => _build();

  _$AttendancesRecord _build() {
    final _$result = _$v ??
        new _$AttendancesRecord._(
            studentName: studentName,
            studentEmail: studentEmail,
            attendanceTime: attendanceTime,
            ffRef: ffRef);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
