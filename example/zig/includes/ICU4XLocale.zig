//! ICU4XLocale generated by diplomat

const std = @import("std");
pub const diplomat_runtime = @import("diplomat_runtime.zig");

const zapi = @This();

pub const ICU4XLocale = opaque {};

pub extern fn ICU4XLocale_new(name_data: [*:0]const u8, name_len: usize) *ICU4XLocale;
pub extern fn ICU4XLocale_destroy(self: ?*ICU4XLocale) void;
