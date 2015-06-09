#include "XMacroExpander.h"

#include "../../UNO/Binary.hxx"

extern "C"
rtl::OUString * expandMacros( uno_Interface * iface, uno_Any ** exception,
    rtl::OUString * exp )
{
    rtl_uString * result = 0;
    void * args [1];
    args[0] = const_cast<rtl_uString **>(&exp->pData);
    makeBinaryUnoCall(iface, "com.sun.star.util.XMacroExpander::expandMacros", &result, args, exception);
    return new rtl::OUString(result, SAL_NO_ACQUIRE);
}
