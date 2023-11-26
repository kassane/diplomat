module ICU4XFixedDecimal;

import modules.diplomat_runtime;
import modules.diplomat_result_void_void;

struct ICU4XFixedDecimal;

extern (C)
{

    ICU4XFixedDecimal* ICU4XFixedDecimal_new(int v);

    void ICU4XFixedDecimal_multiply_pow10(ICU4XFixedDecimal* self, short power);

    diplomat_result_void_void ICU4XFixedDecimal_to_string(const ICU4XFixedDecimal* self, DiplomatWriteable* to);
    void ICU4XFixedDecimal_destroy(ICU4XFixedDecimal* self);

} // extern (C)
