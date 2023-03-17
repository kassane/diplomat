usingnamespace @import("diplomat_runtime.zig");

pub const ICU4XFixedDecimalGroupingStrategy = enum(c_int) {
    ICU4XFixedDecimalGroupingStrategy_Auto = 0,
    ICU4XFixedDecimalGroupingStrategy_Never = 1,
    ICU4XFixedDecimalGroupingStrategy_Always = 2,
    ICU4XFixedDecimalGroupingStrategy_Min2 = 3,
};
