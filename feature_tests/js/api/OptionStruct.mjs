// generated by diplomat-tool
import { OptionOpaque } from "./OptionOpaque.mjs"
import { OptionOpaqueChar } from "./OptionOpaqueChar.mjs"
import wasm from "./diplomat-wasm.mjs";
import * as diplomatRuntime from "./diplomat-runtime.mjs";

export class OptionStruct {

    #a;
    get a()  {
        return this.#a;
    }
    

    #b;
    get b()  {
        return this.#b;
    }
    

    #c;
    get c()  {
        return this.#c;
    }
    

    #d;
    get d()  {
        return this.#d;
    }
    
    constructor() {
        if (arguments.length > 0 && arguments[0] === diplomatRuntime.internalConstructor) {
            this.#fromFFI(...Array.prototype.slice.call(arguments, 1));
        } else {
            console.error("OptionStruct is an out struct and can only be created internally.");
        }
    }

    // Return this struct in FFI function friendly format.
    // Returns an array that can be expanded with spread syntax (...)
    
    _intoFFI(
        functionCleanupArena,
        appendArrayMap
    ) {
        return [this.#a.ffiValue ?? 0, this.#b.ffiValue ?? 0, this.#c, this.#d.ffiValue ?? 0]
    }

    _writeToArrayBuffer(
        arrayBuffer,
        offset,
        functionCleanupArena,
        appendArrayMap
    ) {
        diplomatRuntime.writeToArrayBuffer(arrayBuffer, offset + 0, this.#a.ffiValue ?? 0, Uint32Array);
        diplomatRuntime.writeToArrayBuffer(arrayBuffer, offset + 4, this.#b.ffiValue ?? 0, Uint32Array);
        diplomatRuntime.writeToArrayBuffer(arrayBuffer, offset + 8, this.#c, Uint32Array);
        diplomatRuntime.writeToArrayBuffer(arrayBuffer, offset + 12, this.#d.ffiValue ?? 0, Uint32Array);
    }

    // This struct contains borrowed fields, so this takes in a list of
    // "edges" corresponding to where each lifetime's data may have been borrowed from
    // and passes it down to individual fields containing the borrow.
    // This method does not attempt to handle any dependencies between lifetimes, the caller
    // should handle this when constructing edge arrays.
    #fromFFI(ptr) {
        const aDeref = diplomatRuntime.ptrRead(wasm, ptr);
        this.#a = aDeref === 0 ? null : new OptionOpaque(diplomatRuntime.internalConstructor, aDeref, []);
        const bDeref = diplomatRuntime.ptrRead(wasm, ptr + 4);
        this.#b = bDeref === 0 ? null : new OptionOpaqueChar(diplomatRuntime.internalConstructor, bDeref, []);
        const cDeref = (new Uint32Array(wasm.memory.buffer, ptr + 8, 1))[0];
        this.#c = cDeref;
        const dDeref = diplomatRuntime.ptrRead(wasm, ptr + 12);
        this.#d = dDeref === 0 ? null : new OptionOpaque(diplomatRuntime.internalConstructor, dDeref, []);
    }
}