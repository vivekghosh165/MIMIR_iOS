import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'api_update_record.g.dart';

abstract class ApiUpdateRecord
    implements Built<ApiUpdateRecord, ApiUpdateRecordBuilder> {
  static Serializer<ApiUpdateRecord> get serializer =>
      _$apiUpdateRecordSerializer;

  BuiltList<String>? get name;

  BuiltList<int>? get rollNo;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(ApiUpdateRecordBuilder builder) => builder
    ..name = ListBuilder()
    ..rollNo = ListBuilder();

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('apiUpdate');

  static Stream<ApiUpdateRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<ApiUpdateRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  ApiUpdateRecord._();
  factory ApiUpdateRecord([void Function(ApiUpdateRecordBuilder) updates]) =
      _$ApiUpdateRecord;

  static ApiUpdateRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createApiUpdateRecordData() {
  final firestoreData = serializers.toFirestore(
    ApiUpdateRecord.serializer,
    ApiUpdateRecord(
      (a) => a
        ..name = null
        ..rollNo = null,
    ),
  );

  return firestoreData;
}
