// generated by diplomat-tool
import type { pointer, codepoint } from "./diplomat-runtime.d.ts";

export class MyString {
    

    get ffiValue(): pointer;


    static new_(v: string): MyString;

    static newUnsafe(v: string): MyString;

    static newOwned(v: string): MyString;

    static newFromFirst(v: Array<String>): MyString;

    set str(newStr: string);

    get str(): string;

    static stringTransform(foo: string): string;

    

}