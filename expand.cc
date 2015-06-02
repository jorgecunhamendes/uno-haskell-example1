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

int main() {
    rtl::OUString in("test: $UNO_TYPES :test");
    rtl::OUString out;
    uno_Interface * expanderIfc = setUp();

    rtl_uString * result = 0;
    void * args[1];
    args[0] = const_cast<rtl_uString **>(&in.pData);
    uno_Any * exception = 0;
    makeBinaryUnoCall(
        expanderIfc, "com.sun.star.util.XMacroExpander::expandMacros", &result,
        args, &exception);
    if (exception != 0) {
        assert(false); //TODO: handle exceptions
    }
    assert(result != 0);

    out = rtl::OUString(result, SAL_NO_ACQUIRE);
    std::cout << out.toUtf8().getStr() << '\n';
}
