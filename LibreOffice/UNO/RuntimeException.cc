#include "RuntimeException.h"
#include "Exception.h"

extern "C"
OUString * hsuno_runtimeExceptionGetMessage (RuntimeException * e) {
    return hsuno_exceptionGetMessage(static_cast<Exception *>(e));
}
