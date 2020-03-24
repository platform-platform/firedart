import 'package:firedart/firedart.dart';
import 'package:firedart/src/generated/google/firestore/v1/query.pb.dart';
import 'package:firedart/src/generated/google/protobuf/wrappers.pb.dart';
import 'package:firedart/src/util/firestore_encoding.dart';

class CollectionTestData {
  static const StructuredQuery_CompositeFilter_Operator _filterOperator =
      StructuredQuery_CompositeFilter_Operator.AND;
  static const StructuredQuery_FieldFilter_Operator _fieldFilterOperator =
      StructuredQuery_FieldFilter_Operator.EQUAL;
  static const StructuredQuery_Direction _orderByDirection =
      StructuredQuery_Direction.ASCENDING;
  static const int _value = 1;
  static const String _fieldPath = 'fieldPath';

  static StructuredQuery_CollectionSelector collectionSelector =
      StructuredQuery_CollectionSelector()..collectionId = 'test';
  static StructuredQuery_CompositeFilter testCompositeFilter =
      StructuredQuery_CompositeFilter()
        ..op = _filterOperator
        ..filters.add(
          StructuredQuery_Filter()
            ..fieldFilter = (StructuredQuery_FieldFilter()
              ..op = _fieldFilterOperator
              ..value = FirestoreEncoding.encode(_value)
              ..field_1 =
                  (StructuredQuery_FieldReference()..fieldPath = _fieldPath)),
        );
  static StructuredQuery_Order testOrderBy = StructuredQuery_Order()
    ..field_1 = (StructuredQuery_FieldReference()..fieldPath = _fieldPath)
    ..direction = _orderByDirection;
  static Int32Value testLimit = Int32Value()..value = _value;
}
