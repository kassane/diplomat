// generated by diplomat-tool
import wasm from "./diplomat-wasm.mjs";
import * as diplomatRuntime from "./diplomat-runtime.mjs";


/** An  Locale, capable of representing strings like `"en-US"`.
*
*See the [Rust documentation for `Locale`](https://docs.rs/icu/latest/icu/locid/struct.Locale.html) for more information.
*/
const Locale_box_destroy_registry = new FinalizationRegistry((ptr) => {
    wasm.icu4x_Locale_destroy_mv1(ptr);
});

export class Locale {
    // Internal ptr reference:
    #ptr = null;

    // Lifetimes are only to keep dependencies alive.
    // Since JS won't garbage collect until there are no incoming edges.
    #selfEdge = [];
    
    constructor(ptr, selfEdge) {
        
        this.#ptr = ptr;
        this.#selfEdge = selfEdge;
        // Unconditionally register to destroy when this object is ready to garbage collect.
        Locale_box_destroy_registry.register(this, this.#ptr);
    }

    get ffiValue() {
        return this.#ptr;
    }

    static new_(name) {
        
        const nameSlice = diplomatRuntime.DiplomatBuf.str8(wasm, name);
        const result = wasm.icu4x_Locale_new_mv1(nameSlice.ptr, nameSlice.size);
    
        try {
            return new Locale(result, []);
        }
        
        finally {
            nameSlice.free();
        }
    }
}