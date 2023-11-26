import modules.ICU4XFixedDecimalFormatter;
import modules.diplomat_runtime;
import modules.ICU4XFixedDecimal;
import modules.ICU4XDataProvider;
import modules.ICU4XLocale;

version (D_BetterC)
{
    import core.stdc.stdio;
}
else
{
    import std.stdio;
}

void print_decimal(ICU4XFixedDecimal* fd)
{
    char[40] output = void;
    auto out_ = diplomat_simple_writeable(output.ptr, 40);
    assert(ICU4XFixedDecimal_to_string(fd, &out_).is_ok == true);
    version (D_BetterC)
    {
        output[out_.len] = '\0';
        printf("%s\n", output.ptr);
    }
    else
    {
        writeln("%s", output);
    }
}

void format_decimal(ICU4XFixedDecimalFormatter* fdf, ICU4XFixedDecimal* fd)
{
    char[40] output = void;
    DiplomatWriteable out_ = diplomat_simple_writeable(output.ptr, 40);
    ICU4XFixedDecimalFormatter_format_write(fdf, fd, &out_);
    version (D_BetterC)
    {
        output[out_.len] = '\0';
        printf("%s\n", output.ptr);
    }
    else
    {
        writeln("%s", output);
    }
}

extern (C) void main()
{
    auto fd = ICU4XFixedDecimal_new(123);

    print_decimal(fd);

    ICU4XFixedDecimal_multiply_pow10(fd, -1);
    printf("multiplied by 0.1\n");

    print_decimal(fd);

    auto locale = ICU4XLocale_new("en", 2);
    ICU4XLocale_destroy(locale);

    locale = ICU4XLocale_new("bn", 2);

    auto data_provider = ICU4XDataProvider_new_static();

    auto fdf = ICU4XFixedDecimalFormatter_try_new(locale, data_provider, ICU4XFixedDecimalFormatterOptions_default());
    version (D_BetterC)
    {
        printf("success: %d\n", fdf.is_ok);
    }
    else
    {
        writeln("success: %d", fdf.is_ok);
    }
    format_decimal(fdf.ok, fd);
}
