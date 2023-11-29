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

extern (C++,class)
struct span(T)
{

    private T* data_;
    private size_t size_;
    public this(T* data, size_t size)
    {
        data_ = (data);
        size_ = size;
    }
pure nothrow @nogc:
    public T* data() @safe
    {
        return this.data_;
    }

    public size_t size() const @safe
    {
        return this.size_;
    }

}

unittest {
    import std.stdio;
    auto a = [0, 1, 2, 3, 4, 5, 6, 7, 8];
    span!(int) b = span!(int)(a.ptr, (a).sizeof);

    assert(b.size == (a).sizeof);
    assert(b.data[1] == a[1]);
    writefln("First value: %d", b.data[1]);
    writefln("Size: %d", b.size);
}
