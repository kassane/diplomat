import test from 'ava';
import { MyEnum, MyStruct } from "diplomat-wasm-js-feature-tests";

test("Verify invariants of struct", t => {
    const s = MyStruct.new_();
    t.is(s.a, 17);
    t.is(s.b, true);
    t.is(s.c, 209);
    t.is(s.d, 1234n);
    t.is(s.e, 5991);
    t.is(s.f, '餐'.codePointAt(0));
    t.is(s.g, MyEnum.B);
});
