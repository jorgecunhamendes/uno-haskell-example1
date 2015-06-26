#include "TheMacroExpander.h"

#include "../../UNO/Binary.hxx"

#include "com/sun/star/util/theMacroExpander.hpp"

extern "C"
void * theMacroExpander_new ()
{
    css::uno::Reference< css::util::XMacroExpander > * r =
        new css::uno::Reference< css::util::XMacroExpander >(css::util::theMacroExpander::get(g_context));
    return static_cast< void * >(r);
}
