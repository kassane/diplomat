module diplomat_result_box_ICU4XFixedDecimalFormatter_void;
import modules.diplomat_runtime;
import modules.ICU4XFixedDecimalFormatter;

extern (C)
{
    struct diplomat_result_box_ICU4XFixedDecimalFormatter_void // @suppress(dscanner.style.phobos_naming_convention)
    {
        union
        {
            ICU4XFixedDecimalFormatter* ok;
        }

        bool is_ok;
    }
} // extern(C)
