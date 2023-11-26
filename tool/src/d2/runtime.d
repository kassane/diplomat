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
