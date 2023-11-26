module diplomat_result_void_void;
import modules.diplomat_runtime;

extern (C)
{
    struct diplomat_result_void_void // @suppress(dscanner.style.phobos_naming_convention)
    {
        bool is_ok;
    }
} // extern(C)
