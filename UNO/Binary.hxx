#ifndef UNO_BINARY_H
#define UNO_BINARY_H

#include "com/sun/star/uno/XComponentContext.hpp"
#include "com/sun/star/util/XMacroExpander.hpp"
#include "uno/any2.h"
#include "uno/mapping.hxx"

extern css::uno::Reference<css::uno::XComponentContext> g_context;
extern css::uno::Reference<css::util::XMacroExpander> g_expander;
extern css::uno::Mapping g_cpp2uno;

extern "C"
void makeBinaryUnoCall(
    uno_Interface * interface, char const * methodType, void * result,
    void ** arguments, uno_Any ** exception);

#endif // UNO_BINARY_H
