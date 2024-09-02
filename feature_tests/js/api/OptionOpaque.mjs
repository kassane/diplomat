// generated by diplomat-tool
import { OptionEnum } from "./OptionEnum.mjs"
import { OptionInputStruct } from "./OptionInputStruct.mjs"
import { OptionStruct } from "./OptionStruct.mjs"
import wasm from "./diplomat-wasm.mjs";
import * as diplomatRuntime from "./diplomat-runtime.mjs";

const OptionOpaque_box_destroy_registry = new FinalizationRegistry((ptr) => {
    wasm.OptionOpaque_destroy(ptr);
});

export class OptionOpaque {
    // Internal ptr reference:
    #ptr = null;

    // Lifetimes are only to keep dependencies alive.
    // Since JS won't garbage collect until there are no incoming edges.
    #selfEdge = [];
    
    constructor(symbol, ptr, selfEdge) {
        if (symbol !== diplomatRuntime.internalConstructor) {
            console.error("OptionOpaque is an Opaque type. You cannot call its constructor.");
            return;
        }
        
        this.#ptr = ptr;
        this.#selfEdge = selfEdge;
        
        // Are we being borrowed? If not, we can register.
        if (this.#selfEdge.length === 0) {
            OptionOpaque_box_destroy_registry.register(this, this.#ptr);
        }
    }

    get ffiValue() {
        return this.#ptr;
    }

    static new_(i) {
        const result = wasm.OptionOpaque_new(i);
    
        try {
            return result === 0 ? null : new OptionOpaque(diplomatRuntime.internalConstructor, result, []);
        }
        
        finally {}
    }

    static newNone() {
        const result = wasm.OptionOpaque_new_none();
    
        try {
            return result === 0 ? null : new OptionOpaque(diplomatRuntime.internalConstructor, result, []);
        }
        
        finally {}
    }

    static returns() {
        const diplomatReceive = new diplomatRuntime.DiplomatReceiveBuf(wasm, 17, 4, true);
        
        const result = wasm.OptionOpaque_returns(diplomatReceive.buffer);
    
        try {
            if (!diplomatReceive.resultFlag) {
                return null;
            }
            return new OptionStruct(diplomatRuntime.internalConstructor, diplomatReceive.buffer);
        }
        
        finally {
            diplomatReceive.free();
        }
    }

    optionIsize() {
        const diplomatReceive = new diplomatRuntime.DiplomatReceiveBuf(wasm, 5, 4, true);
        
        const result = wasm.OptionOpaque_option_isize(diplomatReceive.buffer, this.ffiValue);
    
        try {
            if (!diplomatReceive.resultFlag) {
                return null;
            }
            return (new Int32Array(wasm.memory.buffer, diplomatReceive.buffer, 1))[0];
        }
        
        finally {
            diplomatReceive.free();
        }
    }

    optionUsize() {
        const diplomatReceive = new diplomatRuntime.DiplomatReceiveBuf(wasm, 5, 4, true);
        
        const result = wasm.OptionOpaque_option_usize(diplomatReceive.buffer, this.ffiValue);
    
        try {
            if (!diplomatReceive.resultFlag) {
                return null;
            }
            return (new Uint32Array(wasm.memory.buffer, diplomatReceive.buffer, 1))[0];
        }
        
        finally {
            diplomatReceive.free();
        }
    }

    optionI32() {
        const diplomatReceive = new diplomatRuntime.DiplomatReceiveBuf(wasm, 5, 4, true);
        
        const result = wasm.OptionOpaque_option_i32(diplomatReceive.buffer, this.ffiValue);
    
        try {
            if (!diplomatReceive.resultFlag) {
                return null;
            }
            return (new Int32Array(wasm.memory.buffer, diplomatReceive.buffer, 1))[0];
        }
        
        finally {
            diplomatReceive.free();
        }
    }

    optionU32() {
        const diplomatReceive = new diplomatRuntime.DiplomatReceiveBuf(wasm, 5, 4, true);
        
        const result = wasm.OptionOpaque_option_u32(diplomatReceive.buffer, this.ffiValue);
    
        try {
            if (!diplomatReceive.resultFlag) {
                return null;
            }
            return (new Uint32Array(wasm.memory.buffer, diplomatReceive.buffer, 1))[0];
        }
        
        finally {
            diplomatReceive.free();
        }
    }

    static newStruct() {
        const diplomatReceive = new diplomatRuntime.DiplomatReceiveBuf(wasm, 16, 4, false);
        
        const result = wasm.OptionOpaque_new_struct(diplomatReceive.buffer);
    
        try {
            return new OptionStruct(diplomatRuntime.internalConstructor, diplomatReceive.buffer);
        }
        
        finally {
            diplomatReceive.free();
        }
    }

    static newStructNones() {
        const diplomatReceive = new diplomatRuntime.DiplomatReceiveBuf(wasm, 16, 4, false);
        
        const result = wasm.OptionOpaque_new_struct_nones(diplomatReceive.buffer);
    
        try {
            return new OptionStruct(diplomatRuntime.internalConstructor, diplomatReceive.buffer);
        }
        
        finally {
            diplomatReceive.free();
        }
    }

    assertInteger(i) {wasm.OptionOpaque_assert_integer(this.ffiValue, i);
    
        try {}
        
        finally {}
    }

    static optionOpaqueArgument(arg) {
        const result = wasm.OptionOpaque_option_opaque_argument(arg.ffiValue ?? 0);
    
        try {
            return result;
        }
        
        finally {}
    }

    static acceptsOptionU8(arg) {
        const diplomatReceive = new diplomatRuntime.DiplomatReceiveBuf(wasm, 2, 1, true);
        
        const result = wasm.OptionOpaque_accepts_option_u8(diplomatReceive.buffer, ...diplomatRuntime.optionToArgsForCalling(arg, 1, 1, false, (arrayBuffer, offset, jsValue) => [diplomatRuntime.writeToArrayBuffer(arrayBuffer, offset + 0, jsValue, Uint8Array)]));
    
        try {
            if (!diplomatReceive.resultFlag) {
                return null;
            }
            return (new Uint8Array(wasm.memory.buffer, diplomatReceive.buffer, 1))[0];
        }
        
        finally {
            diplomatReceive.free();
        }
    }

    static acceptsOptionEnum(arg) {
        const diplomatReceive = new diplomatRuntime.DiplomatReceiveBuf(wasm, 5, 4, true);
        
        const result = wasm.OptionOpaque_accepts_option_enum(diplomatReceive.buffer, ...diplomatRuntime.optionToArgsForCalling(arg, 4, 4, false, (arrayBuffer, offset, jsValue) => [diplomatRuntime.writeToArrayBuffer(arrayBuffer, offset + 0, jsValue.ffiValue, Int32Array)]));
    
        try {
            if (!diplomatReceive.resultFlag) {
                return null;
            }
            return OptionEnum[Array.from(OptionEnum.values.keys())[diplomatRuntime.enumDiscriminant(wasm, diplomatReceive.buffer)]];
        }
        
        finally {
            diplomatReceive.free();
        }
    }

    static acceptsOptionInputStruct(arg) {
        let functionCleanupArena = new diplomatRuntime.CleanupArena();
        
        const diplomatReceive = new diplomatRuntime.DiplomatReceiveBuf(wasm, 21, 4, true);
        
        const result = wasm.OptionOpaque_accepts_option_input_struct(diplomatReceive.buffer, ...diplomatRuntime.optionToArgsForCalling(arg, 20, 4, false, (arrayBuffer, offset, jsValue) => [jsValue._writeToArrayBuffer(arrayBuffer, offset + 0, functionCleanupArena, {})]));
    
        try {
            if (!diplomatReceive.resultFlag) {
                return null;
            }
            return new OptionInputStruct(diplomatRuntime.internalConstructor, diplomatReceive.buffer);
        }
        
        finally {
            functionCleanupArena.free();
        
            diplomatReceive.free();
        }
    }

    static returnsOptionInputStruct() {
        const diplomatReceive = new diplomatRuntime.DiplomatReceiveBuf(wasm, 20, 4, false);
        
        const result = wasm.OptionOpaque_returns_option_input_struct(diplomatReceive.buffer);
    
        try {
            return new OptionInputStruct(diplomatRuntime.internalConstructor, diplomatReceive.buffer);
        }
        
        finally {
            diplomatReceive.free();
        }
    }
}