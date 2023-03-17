macro_rules! test_file {
    ($($file:tt)*) => {
        let parsed: syn::File = syn::parse_quote! { $($file)* };
        let custom_types = diplomat_core::ast::File::from(&parsed);
        let env = custom_types.all_types();

        let mut out_texts = std::collections::HashMap::new();

        crate::zig::gen_bindings(&env, &mut out_texts).unwrap();

        out_texts.remove("diplomat_runtime.zig");

        for out in out_texts.keys() {
            insta::with_settings!({ snapshot_suffix => out.clone() }, {
                insta::assert_display_snapshot!(out_texts.get(out).unwrap())
            });
        }
    }
}
