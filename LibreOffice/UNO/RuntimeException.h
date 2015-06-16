#ifndef LIBREOFFICE_UNO_RUNTIMEEXCEPTION_H
#define LIBREOFFICE_UNO_RUNTIMEEXCEPTION_H

#include "rtl/ustring.hxx"
#include "com/sun/star/uno/RuntimeException.hpp"

using ::rtl::OUString;
using ::com::sun::star::uno::RuntimeException;

extern "C"
OUString * hsuno_runtimeExceptionGetMessage (RuntimeException * e);

#endif // LIBREOFFICE_UNO_RUNTIMEEXCEPTION_H
