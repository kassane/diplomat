// generated by diplomat-tool
import type { Bar } from "./Bar"
import type { BorrowedFields } from "./BorrowedFields"
import type { BorrowedFieldsWithBounds } from "./BorrowedFieldsWithBounds"
import type { Foo } from "./Foo"
import type { pointer, codepoint } from "./diplomat-runtime.d.ts";

export class NestedBorrowedFields {
    get fields() : BorrowedFields;
    set fields(value: BorrowedFields); 
    get bounds() : BorrowedFieldsWithBounds;
    set bounds(value: BorrowedFieldsWithBounds); 
    get bounds2() : BorrowedFieldsWithBounds;
    set bounds2(value: BorrowedFieldsWithBounds); 

    static fromBarAndFooAndStrings(bar: Bar, foo: Foo, dstr16X: string, dstr16Z: string, utf8StrY: string, utf8StrZ: string): NestedBorrowedFields;

    

}