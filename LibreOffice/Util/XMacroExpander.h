#ifndef LIBREOFFICE_UTIL_XMACROEXPANDER_H
#define LIBREOFFICE_UTIL_XMACROEXPANDER_H

#include "rtl/ustring.hxx"
#include "uno/any2.h"
#include "uno/mapping.hxx"

extern "C"
rtl::OUString * expandMacros( uno_Interface * iface, uno_Any ** exception, rtl::OUString * exp );

#endif // LIBREOFFICE_UTIL_XMACROEXPANDER_H
