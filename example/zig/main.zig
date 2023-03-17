const std = @import("std");
const assert = std.debug.assert;

const fmt = @import("includes/ICU4XFixedDecimalFormatter.zig");
const fmt_opt = @import("includes/ICU4XFixedDecimalFormatterOptions.zig");
const ICU4XFixedDecimalFormatter = fmt.ICU4XFixedDecimalFormatter;
const ICU4XFixedDecimal = @import("includes/ICU4XFixedDecimal.zig");
const ICU4XLocale = fmt.ICU4XLocale;
const ICU4XDataProvider = @import("includes/ICU4XDataProvider.zig");
const diplomat_runtime = @import("includes/diplomat_runtime.zig");
const diplomat_result_box = @import("includes/diplomat_result_box_ICU4XFixedDecimalFormatter_void.zig");

fn print_decimal(fd: ?*ICU4XFixedDecimal.ICU4XFixedDecimal) void {
    var output: [40]u8 = undefined;
    var out = diplomat_runtime.diplomat_simple_writeable(@ptrCast(&output), 40);
    _ = &out; // force mutable
    assert(ICU4XFixedDecimal.ICU4XFixedDecimal_to_string(@constCast(fd), &out).is_ok);
    output[out.len] = '\x00';
    // std.debug.print("{s}\n", .{output}); // works, but undefined
    _ = std.c.printf("%s\n", &output); // works
}
fn format_decimal(fdf: ?*ICU4XFixedDecimalFormatter, fd: ?*ICU4XFixedDecimal.ICU4XFixedDecimal) void {
    var output: [40]u8 = undefined;
    var out = diplomat_runtime.diplomat_simple_writeable(@ptrCast(&output), 40);
    _ = &out; // force mutable
    fmt.ICU4XFixedDecimalFormatter_format_write(@constCast(fdf), @constCast(fd), &out);
    output[out.len] = '\x00';
    // std.debug.print("{s}\n", .{output});
    _ = std.c.printf("%s\n", &output);
}

pub fn main() void {
    const fd = ICU4XFixedDecimal.ICU4XFixedDecimal_new(123);
    print_decimal(@constCast(fd));
    ICU4XFixedDecimal.ICU4XFixedDecimal_multiply_pow10(@constCast(fd), -1);
    std.debug.print("multiplied by 0.1\n", .{});
    print_decimal(@constCast(fd));
    var locale = ICU4XLocale.ICU4XLocale_new("en", 2);
    ICU4XLocale.ICU4XLocale_destroy(locale);
    locale = ICU4XLocale.ICU4XLocale_new("bn", 2);
    const data_provider = ICU4XDataProvider.ICU4XDataProvider_new_static();
    const fdf = fmt.ICU4XFixedDecimalFormatter_try_new(locale, @constCast(data_provider), fmt_opt.ICU4XFixedDecimalFormatterOptions_default());
    std.debug.print("success: {}\n", .{fdf.is_ok});
    format_decimal(@constCast(fdf.unnamed.ok), @constCast(fd));
}
