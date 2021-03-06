#ifndef TEXT_H
#define TEXT_H

#include <rtl/ustring.hxx>

using ::rtl::OUString;

extern "C"
OUString * create_oustring (sal_Unicode * buf, sal_Int32 len);

extern "C"
void delete_oustring (OUString * str);

extern "C"
rtl_uString * oustringGetUString (OUString * str);

extern "C"
OUString * oustringFromUString (rtl_uString * ustr);

#endif // TEXT_H
