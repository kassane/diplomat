module ICU4XFixedDecimalFormatterOptions;

import modules.diplomat_runtime;
import modules.ICU4XFixedDecimalGroupingStrategy;

struct ICU4XFixedDecimalFormatterOptions
{
    ICU4XFixedDecimalGroupingStrategy grouping_strategy;
    bool some_other_config;
}

extern (C)
{

    ICU4XFixedDecimalFormatterOptions ICU4XFixedDecimalFormatterOptions_default();
    void ICU4XFixedDecimalFormatterOptions_destroy(ICU4XFixedDecimalFormatterOptions* self);

} // extern (C)
