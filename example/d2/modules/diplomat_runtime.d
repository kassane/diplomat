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

import core.stdcpp.xutility : StdNamespace;

extern (C++, (StdNamespace)):
extern (C++, class) struct span(ElementType, size_t Extent)
{

    extern (C++)
    alias element_type = ElementType;

    extern (C++)
    alias size_type = size_t;

    extern (C++)
    alias difference_type = ptrdiff_t;

    extern (C++)
    alias pointer = element_type*;

    extern (C++)
    alias const_pointer = const(element_type)*;

pure nothrow @nogc:

    // public extern (C++)
    // span!(element_type, Count) first(size_t Count)();

    // public extern (C++)
    // span!(element_type, Count) last(size_t Count)();

    private element_type* data_;
    private size_type size_;
    
    // public this();
    public this(ElementType* data)
    {
        data_ = (data);
        size_ = Extent;
    }

    // (default) // copy ctor
    // public this(ref const(span!(ElementType, Extent)) other) const ;

    // (default) 
    // public ref span!(ElementType, Extent) opAssign(ref const(span!(ElementType, Extent)) other) const ;

    extern (C++)
    public size_type size() @safe const
    {
        return size_;
    }

    extern (C++)
    public size_type size_bytes() const
    {
        return size * element_type.sizeof;
    }

    extern (C++)
    public bool empty() @safe const
    {
        return (size_ == 0);
    }

    // extern (C++)
    // public ref element_type opIndex(size_type idx) const;
    extern (C++)
    public ref element_type front() @safe
    {
        return data_[0];
    }

    extern (C++)
    public ref element_type back()
    {
        return data_[size() - 1];
    }

    extern (C++)
    public element_type* data() @safe
    {
        return data_;
    }

    extern (C++)
    public int begin() @safe const
    {
        return data_[0];
    }

    extern (C++)
    public int end() @trusted
    {
        return data_[data.sizeof];
    }

    extern (C++)
    public int rbegin() @trusted
    {
        return end();
    }

    extern (C++)
    public int rend() @safe const
    {
        return begin();
    }

}

unittest {
    import core.stdc.stdio : printf;
    
    int[10] a = [34, 56, 78, 23, 1, 0, 54, 94, 62, 5];
    span!(int, 10) b = span!(int, 10)(a.ptr);

    assert(b.size() == (a).length);
    assert(b.data[1] == a[1]);
    printf("First value: %d", b.rend());
    printf("\nSize: %ld", b.size_bytes());
    printf("\nIsEmpty? %d\n", cast(int) b.empty());
}
