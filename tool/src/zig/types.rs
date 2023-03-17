use diplomat_core::Env;
use std::fmt;

use diplomat_core::ast::{self, PrimitiveType};

pub fn gen_type<W: fmt::Write>(
    typ: &ast::TypeName,
    in_path: &ast::Path,
    env: &Env,
    out: &mut W,
) -> fmt::Result {
    match typ {
        ast::TypeName::Named(path_type) | ast::TypeName::SelfType(path_type) => {
            match path_type.resolve(in_path, env) {
                r @ ast::CustomType::Struct(_) | r @ ast::CustomType::Opaque(_) => {
                    write!(out, "{}", r.name())?;
                }

                ast::CustomType::Enum(enm) => {
                    write!(out, "{}", enm.name)?;
                }
                &_ => unreachable!("unknown AST/HIR variant"),
            }
        }

        ast::TypeName::Box(underlying) => {
            write!(out, "*")?;
            gen_type(underlying.as_ref(), in_path, env, out)?;
        }

        ast::TypeName::Reference(_lt, mutable, underlying) => {
            write!(out, "*")?;
            if mutable.is_immutable() {
                write!(out, "const ")?;
            }
            gen_type(underlying.as_ref(), in_path, env, out)?;
        }

        ast::TypeName::Primitive(prim) => {
            write!(out, "{}", zig_type_for_prim(prim))?;
        }

        ast::TypeName::Option(underlying) => match underlying.as_ref() {
            ast::TypeName::Box(_) | ast::TypeName::Reference(..) => {
                gen_type(underlying.as_ref(), in_path, env, out)?;
            }

            _ => unreachable!("Cannot have non-pointer types inside Option"),
        },

        ast::TypeName::Result(_, _, _) => {
            write!(out, "{}", name_for_type(typ))?;
        }

        ast::TypeName::Writeable => write!(out, "DiplomatWriteable")?,
        ast::TypeName::StrReference(_, ast::StringEncoding::UnvalidatedUtf8) => {
            write!(out, "DiplomatStringView")?
        }
        ast::TypeName::StrReference(_, ast::StringEncoding::UnvalidatedUtf16) => {
            write!(out, "DiplomatU16View")?
        }
        ast::TypeName::PrimitiveSlice(_lt, mutability, prim) => {
            if mutability.is_mutable() {
                panic!("Mutable slices in structs not supported");
            }
            let mut prim = prim.to_string();
            prim.get_mut(0..1).unwrap().make_ascii_uppercase();
            write!(out, "Diplomat{prim}View")?;
        }
        ast::TypeName::Unit => write!(out, "void")?,
        &_ => unreachable!("unknown AST/HIR variant"),
    }

    Ok(())
}

/// Generates a struct name that uniquely identifies the given type.
///
/// This is primarily used for generating structs for result types,
/// which require one struct for each distinct instance.
pub fn name_for_type(typ: &ast::TypeName) -> ast::Ident {
    match typ {
        ast::TypeName::Named(name) | ast::TypeName::SelfType(name) => {
            name.path.elements.last().unwrap().clone()
        }
        ast::TypeName::Box(underlying) => {
            ast::Ident::from(format!("box_{}", name_for_type(underlying)))
        }
        ast::TypeName::Reference(_lt, ast::Mutability::Mutable, underlying) => {
            ast::Ident::from(format!("ref_mut_{}", name_for_type(underlying)))
        }
        ast::TypeName::Reference(_lt, ast::Mutability::Immutable, underlying) => {
            ast::Ident::from(format!("ref_{}", name_for_type(underlying)))
        }
        ast::TypeName::Primitive(prim) => ast::Ident::from(zig_type_for_prim(prim)),
        ast::TypeName::Option(underlying) => {
            ast::Ident::from(format!("opt_{}", name_for_type(underlying)))
        }
        ast::TypeName::Result(ok, err, _) => ast::Ident::from(format!(
            "diplomat_result_{}_{}",
            name_for_type(ok),
            name_for_type(err)
        )),
        ast::TypeName::Writeable => ast::Ident::from("writeable"),
        ast::TypeName::StrReference(_, ast::StringEncoding::UnvalidatedUtf8) => {
            ast::Ident::from("str_ref8")
        }
        ast::TypeName::StrReference(_, ast::StringEncoding::UnvalidatedUtf16) => {
            ast::Ident::from("str_ref16")
        }
        ast::TypeName::PrimitiveSlice(_lt, ast::Mutability::Mutable, prim) => {
            ast::Ident::from(format!("ref_mut_prim_slice_{}", zig_type_for_prim(prim)))
        }
        ast::TypeName::PrimitiveSlice(_lt, ast::Mutability::Immutable, prim) => {
            ast::Ident::from(format!("ref_prim_slice_{}", zig_type_for_prim(prim)))
        }
        ast::TypeName::Unit => ast::Ident::from("void"),
        &_ => unreachable!("unknown AST/HIR variant"),
    }
}

pub fn zig_type_for_prim(prim: &PrimitiveType) -> &'static str {
    match prim {
        PrimitiveType::i8 => "i8",
        PrimitiveType::u8 => "u8",
        PrimitiveType::i16 => "i16",
        PrimitiveType::u16 => "u16",
        PrimitiveType::i32 => "i32",
        PrimitiveType::u32 => "u32",
        PrimitiveType::i64 => "i64",
        PrimitiveType::u64 => "u64",
        PrimitiveType::i128 => "i128",
        PrimitiveType::u128 => "u128",
        PrimitiveType::isize => "isize",
        PrimitiveType::usize => "usize",
        PrimitiveType::f32 => "f32",
        PrimitiveType::f64 => "f64",
        PrimitiveType::bool => "bool",
        PrimitiveType::char => "u8",
    }
}

#[cfg(test)]
mod tests {
    #[test]
    fn test_pointer_types() {
        test_file! {
            #[diplomat::bridge]
            mod ffi {
                #[diplomat::opaque]
                struct MyOpaqueStruct(UnknownType);

                struct MyStruct<'a> {
                    a: &'a MyOpaqueStruct,
                }

                impl<'a> MyStruct<'a> {
                    pub fn new(foo: &'a MyOpaqueStruct, bar: &'a mut MyOpaqueStruct) -> MyStruct<'a> {
                        unimplemented!()
                    }
                }
            }
        }
    }

    #[test]
    fn test_option_types() {
        test_file! {
            #[diplomat::bridge]
            mod ffi {
                struct MyStruct {
                    a: Option<Box<MyStruct>>,
                }
            }
        }
    }

    #[test]
    fn test_result_types() {
        test_file! {
            #[diplomat::bridge]
            mod ffi {
                struct MyStruct {
                    a: DiplomatResult<Box<MyStruct>, u8>,
                }

                impl MyStruct {
                    pub fn new() -> Result<MyStruct, u8> {
                        unimplemented!()
                    }
                }
            }
        }
    }

    #[test]
    fn test_empty_result_types() {
        test_file! {
            #[diplomat::bridge]
            mod ffi {
                struct MyStruct {
                    a: DiplomatResult<(), u8>,
                    b: DiplomatResult<(), ()>,
                    c: DiplomatResult<u8, ()>,
                }

                impl MyStruct {
                    pub fn new() -> MyStruct {
                        unimplemented!()
                    }
                }
            }
        }
    }

    #[test]
    fn test_writeable_out() {
        test_file! {
            #[diplomat::bridge]
            mod ffi {
                struct MyStruct;

                impl MyStruct {
                    pub fn write(&self, to: &mut DiplomatWriteable) {
                        unimplemented!()
                    }
                }
            }
        }
    }

    #[test]
    fn test_unit_type() {
        test_file! {
            #[diplomat::bridge]
            mod ffi {
                struct MyStruct;

                impl MyStruct {
                    pub fn something(&self) -> () {
                        unimplemented!()
                    }
                }
            }
        }
    }
}
