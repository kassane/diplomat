const zapi = @This();

pub const DiplomatWriteable = extern struct {
    context: ?*anyopaque,
    buf: ?*u8,
    len: usize,
    cap: usize,
    flush: ?*const fn (?*DiplomatWriteable) callconv(.C) void,
    grow: ?*const fn (?*DiplomatWriteable, usize) callconv(.C) bool,
};
pub const DiplomatStringView = extern struct {
    data: [*:0]const u8,
    len: usize,
};

pub extern fn diplomat_simple_writeable(buf: ?[*:0]const u8, buf_size: usize) DiplomatWriteable;

pub fn make_slice_view(comptime T: type) type {
    return extern struct {
        data: ?*const T,
        len: usize,
    };
}

test "Slice View" {
    _ = make_slice_view(u8);
    _ = make_slice_view(i8);
    _ = make_slice_view(u16);
    _ = make_slice_view(u32);
    _ = make_slice_view(c_int);
    _ = make_slice_view(f32);
    _ = make_slice_view(f64);
    _ = make_slice_view(bool);
}
