import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'attendances_record.g.dart';

abstract class AttendancesRecord
    implements Built<AttendancesRecord, AttendancesRecordBuilder> {
  static Serializer<AttendancesRecord> get serializer =>
      _$attendancesRecordSerializer;

  String? get studentName;

  String? get studentEmail;

  DateTime? get attendanceTime;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  DocumentReference get parentReference => reference.parent.parent!;

  static void _initializeBuilder(AttendancesRecordBuilder builder) => builder
    ..studentName = ''
    ..studentEmail = '';

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('attendances')
          : FirebaseFirestore.instance.collectionGroup('attendances');

  static DocumentReference createDoc(DocumentReference parent) =>
      parent.collection('attendances').doc();

  static Stream<AttendancesRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<AttendancesRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  AttendancesRecord._();
  factory AttendancesRecord([void Function(AttendancesRecordBuilder) updates]) =
      _$AttendancesRecord;

  static AttendancesRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createAttendancesRecordData({
  String? studentName,
  String? studentEmail,
  DateTime? attendanceTime,
}) {
  final firestoreData = serializers.toFirestore(
    AttendancesRecord.serializer,
    AttendancesRecord(
      (a) => a
        ..studentName = studentName
        ..studentEmail = studentEmail
        ..attendanceTime = attendanceTime,
    ),
  );

  return firestoreData;
}
