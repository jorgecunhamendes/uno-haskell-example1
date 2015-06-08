#include "sal/config.h"

#include <cassert>
#include <iostream>

#include "com/sun/star/uno/Reference.hxx"
#include "com/sun/star/uno/Type.hxx"
#include "com/sun/star/uno/TypeClass.hpp"
#include "com/sun/star/uno/XComponentContext.hpp"
#include "com/sun/star/util/XMacroExpander.hpp"
#include "com/sun/star/util/theMacroExpander.hpp"
#include "cppuhelper/bootstrap.hxx"
#include "rtl/ustring.h"
#include "rtl/ustring.hxx"
#include "sal/types.h"
#include "typelib/typedescription.h"
#include "uno/any2.h"
#include "uno/dispatcher.h"
#include "uno/mapping.hxx"

namespace {

css::uno::Reference<css::uno::XComponentContext> g_context;
css::uno::Reference<css::util::XMacroExpander> g_expander;
css::uno::Mapping g_cpp2uno;

}

extern "C" uno_Interface * setUp() {
    g_context = cppu::defaultBootstrap_InitialComponentContext();
    g_expander = css::util::theMacroExpander::get(g_context);
    g_cpp2uno = css::uno::Mapping(
        css::uno::Environment::getCurrent(), css::uno::Environment(UNO_LB_UNO));

    return static_cast<uno_Interface *>(
        g_cpp2uno.mapInterface(
            g_expander.get(),
            cppu::UnoType<css::util::XMacroExpander>::get()));
}

extern "C" void makeBinaryUnoCall(
    uno_Interface * interface, char const * methodType, void * result,
    void ** arguments, uno_Any ** exception)
{
    typelib_TypeDescription * td = 0;
    css::uno::Type(css::uno::TypeClass_INTERFACE_METHOD, methodType)
        .getDescription(&td);
    assert(td != 0); // for now, just assert
    (*interface->pDispatcher)(interface, td, result, arguments, exception);
    typelib_typedescription_release(td);
}
