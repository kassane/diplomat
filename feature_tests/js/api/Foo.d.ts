// generated by diplomat-tool
import type { Bar } from "./Bar"
import type { BorrowedFields } from "./BorrowedFields"
import type { BorrowedFieldsReturning } from "./BorrowedFieldsReturning"
import type { BorrowedFieldsWithBounds } from "./BorrowedFieldsWithBounds"
import type { pointer, codepoint } from "./diplomat-runtime.d.ts";

export class Foo {
    

    get ffiValue(): pointer;

    static new_(x: string): Foo;

    get bar(): Bar;

    static newStatic(x: string): Foo;

    asReturning(): BorrowedFieldsReturning;

    static extractFromFields(fields: BorrowedFields): Foo;

    static extractFromBounds(bounds: BorrowedFieldsWithBounds, anotherString: string): Foo;
}