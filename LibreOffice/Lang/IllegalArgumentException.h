#ifndef LIBREOFFICE_LANG_ILLEGALARGUMENTEXCEPTION_H
#define LIBREOFFICE_LANG_ILLEGALARGUMENTEXCEPTION_H

#include "rtl/ustring.hxx"
#include "com/sun/star/lang/IllegalArgumentException.hpp"

using ::rtl::OUString;
using ::com::sun::star::lang::IllegalArgumentException;

extern "C"
OUString * hsuno_illegalArgumentExceptionGetMessage (IllegalArgumentException * e);

extern "C"
sal_Int16 hsuno_illegalArgumentExceptionGetArgumentPosition (IllegalArgumentException * e);

#endif // LIBREOFFICE_LANG_ILLEGALARGUMENTEXCEPTION_H
