module ICU4XDataProvider;

import modules.diplomat_runtime;
import modules.diplomat_result_void_void;

struct ICU4XDataProvider;

extern (C)
{

    ICU4XDataProvider* ICU4XDataProvider_new_static();

    diplomat_result_void_void ICU4XDataProvider_returns_result();
    void ICU4XDataProvider_destroy(ICU4XDataProvider* self);

} // extern (C)
