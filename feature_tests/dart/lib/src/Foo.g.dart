// generated by diplomat-tool

// https://github.com/dart-lang/sdk/issues/53946
// ignore_for_file: non_native_function_type_argument_to_pointer

part of 'lib.g.dart';

final class Foo implements ffi.Finalizable {
  final ffi.Pointer<ffi.Opaque> _underlying;

  Foo._(this._underlying) {
    _finalizer.attach(this, _underlying.cast());
  }

  static final _finalizer = ffi.NativeFinalizer(_capi('Foo_destroy'));

  factory Foo(String x) {
    final temp = ffi2.Arena();
    final xView = x.utf8View;
    final result = _Foo_new(xView.pointer(temp), xView.length);
    temp.releaseAll();
    return Foo._(result);
  }

  // ignore: non_constant_identifier_names
  static final _Foo_new =
    _capi<ffi.NativeFunction<ffi.Pointer<ffi.Opaque> Function(ffi.Pointer<ffi.Uint8>, ffi.Size)>>('Foo_new')
      .asFunction<ffi.Pointer<ffi.Opaque> Function(ffi.Pointer<ffi.Uint8>, int)>(isLeaf: true);

  Bar get getBar {
    final result = _Foo_get_bar(_underlying);
    return Bar._(result);
  }

  // ignore: non_constant_identifier_names
  static final _Foo_get_bar =
    _capi<ffi.NativeFunction<ffi.Pointer<ffi.Opaque> Function(ffi.Pointer<ffi.Opaque>)>>('Foo_get_bar')
      .asFunction<ffi.Pointer<ffi.Opaque> Function(ffi.Pointer<ffi.Opaque>)>(isLeaf: true);

  factory Foo.static_(String x) {
    final temp = ffi2.Arena();
    final xView = x.utf8View;
    final result = _Foo_new_static(xView.pointer(temp), xView.length);
    temp.releaseAll();
    return Foo._(result);
  }

  // ignore: non_constant_identifier_names
  static final _Foo_new_static =
    _capi<ffi.NativeFunction<ffi.Pointer<ffi.Opaque> Function(ffi.Pointer<ffi.Uint8>, ffi.Size)>>('Foo_new_static')
      .asFunction<ffi.Pointer<ffi.Opaque> Function(ffi.Pointer<ffi.Uint8>, int)>(isLeaf: true);

  BorrowedFieldsReturning get asReturning {
    final result = _Foo_as_returning(_underlying);
    return BorrowedFieldsReturning._(result);
  }

  // ignore: non_constant_identifier_names
  static final _Foo_as_returning =
    _capi<ffi.NativeFunction<_BorrowedFieldsReturningFfi Function(ffi.Pointer<ffi.Opaque>)>>('Foo_as_returning')
      .asFunction<_BorrowedFieldsReturningFfi Function(ffi.Pointer<ffi.Opaque>)>(isLeaf: true);

  factory Foo.extractFromFields(BorrowedFields fields) {
    final result = _Foo_extract_from_fields(fields._underlying);
    return Foo._(result);
  }

  // ignore: non_constant_identifier_names
  static final _Foo_extract_from_fields =
    _capi<ffi.NativeFunction<ffi.Pointer<ffi.Opaque> Function(_BorrowedFieldsFfi)>>('Foo_extract_from_fields')
      .asFunction<ffi.Pointer<ffi.Opaque> Function(_BorrowedFieldsFfi)>(isLeaf: true);
}
