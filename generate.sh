swig -java -package com.valvesoftware.phonon -outdir generated phonon.i
gcc -g3 -fPIC -Wall -Wextra -shared phonon_wrap.c -o libphononjni.so -L. -lphonon -I/usr/lib/jvm/java-8-openjdk-amd64/include -I/usr/lib/jvm/java-8-openjdk-amd64/include/linux
