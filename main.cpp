#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <iostream>

#include "TutorialConfig.h"

#ifdef USE_MYMATH
    #include "MathFunctions.h"
#endif

int main(int argc, char** argv) {
    if (argc < 2) {
        std::cout << argv[0] << " Version " << Tutorial_VERSION_MAJOR
        << "." << Tutorial_VERSION_MINOR << std::endl;
        return 1;
    }
    double inputValue = atof(argv[1]);
#ifndef USE_MYMATH
    double outputValue = sqrt(inputValue);
#else
    double outputValue = mathfunctions::sqrt(inputValue);
#endif

    fprintf(stdout, "The square root of %g is %g\n",
            inputValue, outputValue);
    return 0;
}