%module(directors="1") uds

%begin %{
#include <cmath>
%}

%{
#include "uds.h"
#include "uds_j2534.h"
%}
%include "exception.i"

%import "j2534.i"

//
// Exceptions
//
%exception {
    try {
        $action
    } catch (const std::exception& e) {
        SWIG_exception(SWIG_RuntimeError, e.what());
    }
}

%extend UDSException {
  const char *__str__() {
    return self->what();
  }
};

%catches(J2534FunctionException, UDSException) UDS_J2534::send;

//
// Shared pointers
//
%include <std_shared_ptr.i>
%shared_ptr(UDS)
%shared_ptr(UDS_J2534)
%shared_ptr(UDSMessage)
%shared_ptr(UDSNegativeResponseMessage)

//
// Specific behaviours
//
%include <pybuffer.i>
%pybuffer_mutable_binary(uint8_t *data, size_t length);
UDSMessage::UDSMessage(uint8_t *data, size_t length);

%include "iso14229.h"
%include "uds.h"
%include "uds_j2534.h"

