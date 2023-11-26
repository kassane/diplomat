module ICU4XLocale;

import modules.diplomat_runtime;

struct ICU4XLocale;
extern (C)
{

    ICU4XLocale* ICU4XLocale_new(const(char)* name_data, size_t name_len);
    void ICU4XLocale_destroy(ICU4XLocale* self);

} // extern (C)
