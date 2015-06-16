#include "Exception.h"

extern "C"
OUString * hsuno_exceptionGetMessage (Exception * e) {
    return &e->Message;
}
