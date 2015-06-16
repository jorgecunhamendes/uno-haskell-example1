#include "IllegalArgumentException.h"

#include "../UNO/RuntimeException.h"

extern "C"
OUString * hsuno_illegalArgumentExceptionGetMessage (IllegalArgumentException * e) {
    return hsuno_runtimeExceptionGetMessage(static_cast<RuntimeException *>(e));
}

extern "C"
sal_Int16 hsuno_illegalArgumentExceptionGetArgumentPosition (IllegalArgumentException * e) {
    return e->ArgumentPosition;
}
