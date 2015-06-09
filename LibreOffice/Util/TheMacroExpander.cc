#include "TheMacroExpander.h"

#include "../../UNO/Binary.hxx"

#include "com/sun/star/util/theMacroExpander.hpp"

extern "C"
uno_Interface * theMacroExpander_new ()
{
    g_expander = css::util::theMacroExpander::get(g_context);
    g_cpp2uno = css::uno::Mapping(
        css::uno::Environment::getCurrent(), css::uno::Environment(UNO_LB_UNO));

    return static_cast<uno_Interface *>(
        g_cpp2uno.mapInterface(
            g_expander.get(),
            cppu::UnoType<css::util::XMacroExpander>::get()));
}
