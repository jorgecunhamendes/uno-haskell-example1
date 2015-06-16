#include "Binary.hxx"

#include "cppuhelper/bootstrap.hxx"
#include "uno/dispatcher.h"
#include "com/sun/star/uno/Any.hxx"

#include "com/sun/star/uno/Exception.hpp"
#include "com/sun/star/uno/RuntimeException.hpp"
#include "com/sun/star/lang/IllegalArgumentException.hpp"

using ::com::sun::star::uno::Any;
using ::com::sun::star::uno::Exception;
using ::com::sun::star::uno::RuntimeException;
using ::com::sun::star::lang::IllegalArgumentException;

css::uno::Reference<css::uno::XComponentContext> g_context;
css::uno::Reference<css::util::XMacroExpander> g_expander;
css::uno::Mapping g_cpp2uno;

int stringSizeOf = sizeof(std::string);
int exceptionSizeOf = sizeof(Exception);
int exceptionAlignment = 8;

extern "C"
void bootstrap()
{
    g_context = cppu::defaultBootstrap_InitialComponentContext();
}

extern "C"
void makeBinaryUnoCall(
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

extern "C"
uno_Any * makeAnyFromBool (bool a)
{
    Any * any = new Any(a);
    return static_cast< uno_Any * >(any);
}

extern "C"
uno_Any * makeAnyFromInt32 (sal_Int32 * a)
{
    Any * any = new Any(a, cppu::UnoType<sal_Int32>::get());
    return static_cast< uno_Any * >(any);
}

extern "C"
uno_Any * makeAnyFromInt64 (sal_Int64 * a)
{
    Any * any = new Any(a, cppu::UnoType<sal_Int64>::get());
    return static_cast< uno_Any * >(any);
}

extern "C"
bool anyToBool (uno_Any * any)
{
    bool a;
    *static_cast< Any * >(any) >>= a;
    return a;
}

extern "C"
sal_Int32 anyToInt32 (uno_Any * any)
{
    sal_Int32 a;
    *static_cast< Any * >(any) >>= a;
    return a;
}

extern "C"
sal_Int64 anyToInt64 (uno_Any * any)
{
    sal_Int64 a;
    *static_cast< Any * >(any) >>= a;
    return a;
}

extern "C"
Exception * anyToException (uno_Any * any)
{
    Exception * a = new Exception();
    *static_cast< Any * >(any) >>= *a;
    return a;
}

extern "C"
IllegalArgumentException * anyToIllegalArgumentException (uno_Any * any)
{
    IllegalArgumentException * a = new IllegalArgumentException();
    *static_cast< Any * >(any) >>= *a;
    return a;
}
