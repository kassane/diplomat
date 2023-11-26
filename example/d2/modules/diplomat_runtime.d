module diplomat_runtime;

extern (C):
__gshared:

struct DiplomatWriteable
{
    void* context = void;
    char* buf = void;
    size_t len = void;
    size_t cap = void;
    void function(DiplomatWriteable*) flush = void;
    bool function(DiplomatWriteable*, size_t) grow = void;
}

extern(C) DiplomatWriteable diplomat_simple_writeable(char* buf, size_t buf_size);

struct DiplomatStringView
{
    const(char)* data = void;
    size_t len = void;
}

DiplomatWriteable WriteableFromString(ref string string_) { // @suppress(dscanner.style.phobos_naming_convention)
  DiplomatWriteable w;
  w.context = &string_;
  w.buf = &string_[0];
  w.len = string_.length;
  // Same as length, since C++ strings are not supposed
  // to be written to past their len; you resize *first*
  w.cap = string_.length;
  w.flush = Flush;
  w.grow = Grow;
  return w;
}

// enum string MAKE_SLICE_VIEW(string name, string c_ty) = `\
//     struct Diplomat##name##View { \
//         const (c_ty)* data; \
//         size_t len; \
//     }`;

// mixin(MAKE_SLICE_VIEW!(`I8`, `byte`));
// mixin(MAKE_SLICE_VIEW!(`U8`, `ubyte`));
// mixin(MAKE_SLICE_VIEW!(`I16`, `short`));
// mixin(MAKE_SLICE_VIEW!(`U16`, `ushort`));
// mixin(MAKE_SLICE_VIEW!(`I32`, `int`));
// mixin(MAKE_SLICE_VIEW!(`U32`, `uint`));
// mixin(MAKE_SLICE_VIEW!(`I64`, `long`));
// mixin(MAKE_SLICE_VIEW!(`U64`, `ulong`));
// mixin(MAKE_SLICE_VIEW!(`Isize`, `intptr_t`));
// mixin(MAKE_SLICE_VIEW!(`Usize`, `size_t`));
// mixin(MAKE_SLICE_VIEW!(`F32`, `float`));
// mixin(MAKE_SLICE_VIEW!(`F64`, `double`));
// mixin(MAKE_SLICE_VIEW!(`Bool`, `bool`));
// mixin(MAKE_SLICE_VIEW!(`Char`, `char`));

class span(T, size_t N) // @suppress(dscanner.style.phobos_naming_convention)
{
    this(T* data)
    {
        data_ = data;
        size_ = N;
    }

    this(T[N] args...)
    {
        this[] = args[];
    }

    this(ref T[] arr)
    {
        data ~= cast(T*) arr.ptr;
        size_ = N;
    }

pure nothrow @nogc:

    T* data() const @safe
    {
        return data_;
    }

    size_t size() const @safe
    {
        return size_;
    }

private:
    T* data_;
    size_t size_;
}
