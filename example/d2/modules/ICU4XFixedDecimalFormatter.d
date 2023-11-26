module ICU4XFixedDecimalFormatter;

import modules.diplomat_runtime;
import modules.ICU4XLocale;
import modules.ICU4XDataProvider;
public import modules.ICU4XFixedDecimalFormatterOptions;
import modules.diplomat_result_box_ICU4XFixedDecimalFormatter_void;
import modules.ICU4XFixedDecimal;

struct ICU4XFixedDecimalFormatter;

extern (C)
{

    diplomat_result_box_ICU4XFixedDecimalFormatter_void ICU4XFixedDecimalFormatter_try_new(const ICU4XLocale* locale, const ICU4XDataProvider* provider, ICU4XFixedDecimalFormatterOptions options);

    void ICU4XFixedDecimalFormatter_format_write(const ICU4XFixedDecimalFormatter* self, const ICU4XFixedDecimal* value, DiplomatWriteable* write);
    void ICU4XFixedDecimalFormatter_destroy(ICU4XFixedDecimalFormatter* self);

} // extern (C)
