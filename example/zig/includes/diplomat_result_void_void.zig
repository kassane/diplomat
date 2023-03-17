pub const diplomat_runtime = @import("diplomat_runtime.zig");

pub const diplomat_result_void_void = extern struct {
    is_ok: bool,
};
