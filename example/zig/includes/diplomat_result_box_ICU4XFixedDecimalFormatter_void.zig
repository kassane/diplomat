const diplomat_runtime = @import("diplomat_runtime.zig");

const ICU4XFixedDecimalFormatter = @import("ICU4XFixedDecimalFormatter.zig").ICU4XFixedDecimalFormatter;
pub const diplomat_result_box_ICU4XFixedDecimalFormatter_void = extern struct {
    unnamed: extern union {
        ok: ?*ICU4XFixedDecimalFormatter,
    },
    is_ok: bool,
};
