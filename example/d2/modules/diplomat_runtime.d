module diplomat_runtime;

extern (C):
struct DiplomatWriteable
{
    void* context = void;
    char* buf = void;
    size_t len = void;
    size_t cap = void;
    void function(DiplomatWriteable*) flush = void;
    bool function(DiplomatWriteable*, size_t) grow = void;
}

DiplomatWriteable diplomat_simple_writeable(char* buf, size_t buf_size) @safe;

struct DiplomatStringView
{
    const(char)* data = void;
    size_t len = void;
}

void Flush(DiplomatWriteable* w) {
    string str = cast(string*) w.context;
    str.length = w.len;
}

import core.stdc.stdint : uintptr_t;
bool Grow(DiplomatWriteable* w, uintptr_t requested) {
    string str = cast(string*) w.context;
    str.length = requested;
    w.cap = string.length;
    w.buf = &string[0];
    return true;
}

DiplomatWriteable WriteableFromString(ref string str) {
    DiplomatWriteable w;
    w.context = &str;
    w.buf = str.ptr;
    w.len = str.length;
    w.cap = str.length;
    w.flush = &Flush;
    w.grow = &Grow;
    return w;
}

extern(D):
template WriteableTrait(T) {
    static DiplomatWriteable Construct(T t);
}

template WriteableTrait(string) {
    static DiplomatWriteable Construct(string t) {
        return WriteableFromString(t);
    }
}

import std.typecons : Nullable;
struct Ok(T)
{

    private T value;

    this(T val)
    {
        value = val;
    }

}

struct Err(T)
{

    private T error;

    this(T err)
    {
        error = err;
    }

}

struct Result(T, E)
{

    private Nullable!(Ok!T) okVal;
    private Nullable!(Err!E) errVal;

    static Result!(T, E) ok(T value)
    {
        auto res = Result!(T, E)();
        res.okVal = Ok!T(value);
        return res;
    }

    static Result!(T, E) err(E error)
    {
        auto res = Result!(T, E)();
        res.errVal = Err!E(error);
        return res;
    }
}

unittest
{
    Result!(int, string) res1 = Result!(int, string).ok(10);
    Result!(int, string) res2 = Result!(int, string).err("error");

    assert(res1.okVal.get.value == 10);
    assert(res2.errVal.get.error == "error");
}

import core.stdcpp.xutility : StdNamespace;
extern (C++, (StdNamespace)):
enum dynamic_extent = size_t.max;
extern (C++, class) struct span(ElementType, size_t Extent = dynamic_extent)
{

    alias element_type = ElementType;
    alias size_type = size_t;
    alias difference_type = ptrdiff_t;
    alias pointer = element_type*;
    alias const_pointer = const(element_type)*;

    private element_type* data_;
    private size_type size_;
    
    this(ElementType* data)
    {
        data_ = (data);
        size_ = Extent;
    }

pure nothrow @nogc:

    size_type size() @safe const
    {
        return size_;
    }

    size_type size_bytes() const
    {
        return size * element_type.sizeof;
    }

    bool empty() @safe const
    {
        return (size_ == 0);
    }

    ref element_type front() @safe
    {
        return data_[0];
    }

    ref element_type back()
    {
        return data_[size() - 1];
    }

    element_type* data() @safe
    {
        return data_;
    }

    int begin() @safe const
    {
        return data_[0];
    }

    int end() @trusted
    {
        return data_[data.sizeof];
    }

    int rbegin() @trusted
    {
        return end();
    }

    int rend() @safe const
    {
        return begin();
    }
}

unittest {
    int[10] a = [34, 56, 78, 23, 1, 0, 54, 94, 62, 5];
    span!(int, 10) b = span!(int, 10)(a.ptr);

    assert(b.size == (a).length);
    assert(b.begin == a[0]);

    // import core.stdc.stdio : printf;
    // printf("First value: %d", b.rend());
    // printf("\nSize: %ld", b.size_bytes());
    // printf("\nIsEmpty? %d\n", cast(int) b.empty());
}
