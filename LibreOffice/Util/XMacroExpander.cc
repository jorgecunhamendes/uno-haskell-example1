#include "XMacroExpander.h"

#include "cppu/unotype.hxx"

#include "../../UNO/Binary.hxx"

extern "C"
rtl::OUString * expandMacros(void * rIface , uno_Any ** exception,
    rtl::OUString * exp )
{
    // prepare interface
    css::uno::Reference< css::util::XMacroExpander > * rIface2 =
      static_cast< css::uno::Reference< css::util::XMacroExpander > * >(rIface);
    uno_Interface * iface = static_cast<uno_Interface *>(
        g_cpp2uno.mapInterface(
            rIface2->get(),
            cppu::UnoType<css::util::XMacroExpander>::get()));

    rtl_uString * result = 0;
    void * args [1];
    args[0] = const_cast<rtl_uString **>(&exp->pData);
    makeBinaryUnoCall(iface, "com.sun.star.util.XMacroExpander::expandMacros", &result, args, exception);
    return new rtl::OUString(result, SAL_NO_ACQUIRE);
}
