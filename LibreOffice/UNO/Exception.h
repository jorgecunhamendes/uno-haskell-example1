#ifndef LIBREOFFICE_UNO_EXCEPTION_H
#define LIBREOFFICE_UNO_EXCEPTION_H

#include "com/sun/star/uno/Exception.hpp"

using ::rtl::OUString;
using ::com::sun::star::uno::Exception;

extern "C"
OUString * hsuno_exceptionGetMessage (Exception * e);

#endif // LIBREOFFICE_UNO_EXCEPTION_H
