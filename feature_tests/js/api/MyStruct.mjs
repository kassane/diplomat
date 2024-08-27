// generated by diplomat-tool
import { MyEnum } from "./MyEnum.mjs"
import { MyZst } from "./MyZst.mjs"
import wasm from "./diplomat-wasm.mjs";
import * as diplomatRuntime from "./diplomat-runtime.mjs";

export class MyStruct {

    #a;
    get a()  {
        return this.#a;
    }
    set a(value) {
        this.#a = value;
    }

    #b;
    get b()  {
        return this.#b;
    }
    set b(value) {
        this.#b = value;
    }

    #c;
    get c()  {
        return this.#c;
    }
    set c(value) {
        this.#c = value;
    }

    #d;
    get d()  {
        return this.#d;
    }
    set d(value) {
        this.#d = value;
    }

    #e;
    get e()  {
        return this.#e;
    }
    set e(value) {
        this.#e = value;
    }

    #f;
    get f()  {
        return this.#f;
    }
    set f(value) {
        this.#f = value;
    }

    #g;
    get g()  {
        return this.#g;
    }
    set g(value) {
        this.#g = value;
    }
    constructor() {
        if (arguments.length > 0 && arguments[0] === diplomatRuntime.internalConstructor) {
            this.#fromFFI(...Array.prototype.slice.call(arguments, 1));
        } else {
            
            this.#a = arguments[0];
            this.#b = arguments[1];
            this.#c = arguments[2];
            this.#d = arguments[3];
            this.#e = arguments[4];
            this.#f = arguments[5];
            this.#g = arguments[6];
        }
    }

    // Return this struct in FFI function friendly format.
    // Returns an array that can be expanded with spread syntax (...)
    
    _intoFFI(
        functionCleanupArena,
        appendArrayMap
    ) {
        return [this.#a, this.#b, this.#c, /* [5 x i8] padding */ 0, 0, 0, 0, 0 /* end padding */, this.#d, this.#e, this.#f, this.#g.ffiValue, /* [1 x i32] padding */ 0 /* end padding */]
    }

    // This struct contains borrowed fields, so this takes in a list of
    // "edges" corresponding to where each lifetime's data may have been borrowed from
    // and passes it down to individual fields containing the borrow.
    // This method does not attempt to handle any dependencies between lifetimes, the caller
    // should handle this when constructing edge arrays.
    #fromFFI(ptr) {
        const aDeref = (new Uint8Array(wasm.memory.buffer, ptr, 1))[0];
        this.#a = aDeref;
        const bDeref = (new Uint8Array(wasm.memory.buffer, ptr + 1, 1))[0] === 1;
        this.#b = bDeref;
        const cDeref = (new Uint8Array(wasm.memory.buffer, ptr + 2, 1))[0];
        this.#c = cDeref;
        const dDeref = (new BigUint64Array(wasm.memory.buffer, ptr + 8, 1))[0];
        this.#d = dDeref;
        const eDeref = (new Int32Array(wasm.memory.buffer, ptr + 16, 1))[0];
        this.#e = eDeref;
        const fDeref = (new Uint32Array(wasm.memory.buffer, ptr + 20, 1))[0];
        this.#f = fDeref;
        const gDeref = diplomatRuntime.enumDiscriminant(wasm, ptr + 24);
        this.#g = (() => {for (let i of MyEnum.values) { if(i[1] === gDeref) return MyEnum[i[0]]; } return null;})();
    }

    static new_() {
        const diplomatReceive = new diplomatRuntime.DiplomatReceiveBuf(wasm, 28, 8, false);
        
        const result = wasm.MyStruct_new(diplomatReceive.buffer);
    
        try {
            return new MyStruct(diplomatRuntime.internalConstructor, diplomatReceive.buffer);
        }
        
        finally {
            diplomatReceive.free();
        }
    }

    intoA() {
        let functionCleanupArena = new diplomatRuntime.CleanupArena();
        
        const result = wasm.MyStruct_into_a(...this._intoFFI());
    
        try {
            return result;
        }
        
        finally {
            functionCleanupArena.free();
        }
    }

    static returnsZstResult() {
        const result = wasm.MyStruct_returns_zst_result();
    
        try {
            if (result !== 1) {
                const cause = new MyZst(diplomatRuntime.internalConstructor);
                throw new globalThis.Error('MyZst', { cause });
            }
    
        }
        
        finally {}
    }

    static failsZstResult() {
        const result = wasm.MyStruct_fails_zst_result();
    
        try {
            if (result !== 1) {
                const cause = new MyZst(diplomatRuntime.internalConstructor);
                throw new globalThis.Error('MyZst', { cause });
            }
    
        }
        
        finally {}
    }
}