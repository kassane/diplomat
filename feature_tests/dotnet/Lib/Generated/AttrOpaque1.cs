// <auto-generated/> by Diplomat

#pragma warning disable 0105
using System;
using System.Runtime.InteropServices;

using DiplomatFeatures.Diplomat;
#pragma warning restore 0105

namespace DiplomatFeatures;

#nullable enable

public partial class AttrOpaque1: IDisposable
{
    private unsafe Raw.AttrOpaque1* _inner;

    /// <summary>
    /// Creates a managed <c>AttrOpaque1</c> from a raw handle.
    /// </summary>
    /// <remarks>
    /// Safety: you should not build two managed objects using the same raw handle (may causes use-after-free and double-free).
    /// <br/>
    /// This constructor assumes the raw struct is allocated on Rust side.
    /// If implemented, the custom Drop implementation on Rust side WILL run on destruction.
    /// </remarks>
    public unsafe AttrOpaque1(Raw.AttrOpaque1* handle)
    {
        _inner = handle;
    }

    /// <returns>
    /// A <c>AttrOpaque1</c> allocated on Rust side.
    /// </returns>
    public static AttrOpaque1 New()
    {
        unsafe
        {
            Raw.AttrOpaque1* retVal = Raw.AttrOpaque1.New();
            return new AttrOpaque1(retVal);
        }
    }

    public byte Method()
    {
        unsafe
        {
            if (_inner == null)
            {
                throw new ObjectDisposedException("AttrOpaque1");
            }
            byte retVal = Raw.AttrOpaque1.Method(_inner);
            return retVal;
        }
    }

    public byte Crenamed()
    {
        unsafe
        {
            if (_inner == null)
            {
                throw new ObjectDisposedException("AttrOpaque1");
            }
            byte retVal = Raw.AttrOpaque1.Crenamed(_inner);
            return retVal;
        }
    }

    public void MethodDisabledcpp()
    {
        unsafe
        {
            if (_inner == null)
            {
                throw new ObjectDisposedException("AttrOpaque1");
            }
            Raw.AttrOpaque1.MethodDisabledcpp(_inner);
        }
    }

    /// <summary>
    /// Returns the underlying raw handle.
    /// </summary>
    public unsafe Raw.AttrOpaque1* AsFFI()
    {
        return _inner;
    }

    /// <summary>
    /// Destroys the underlying object immediately.
    /// </summary>
    public void Dispose()
    {
        unsafe
        {
            if (_inner == null)
            {
                return;
            }

            Raw.AttrOpaque1.Destroy(_inner);
            _inner = null;

            GC.SuppressFinalize(this);
        }
    }

    ~AttrOpaque1()
    {
        Dispose();
    }
}
