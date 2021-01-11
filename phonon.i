%module phonon
%{
/* Includes the header in the wrapper code */
#include "phonon.h"
#include "phonon_version.h"
%}

%include "enums.swg"
%javaconst(1);

%apply bool { enum IPLbool };

/* Parse the header file to generate wrappers */
%include "phonon.h"
%include "phonon_version.h"
