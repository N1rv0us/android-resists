//
// Created by reveny on 10/07/2023.
//

#include "../Include/Logger.h"
#include "RemapTools.h"

#include <pthread.h>
#include <unistd.h>
#include <dlfcn.h>

extern "C" {
void fuck_you() {
    LOGE("FUCK YOU !!!!!!");
}
}

[[noreturn]] void *thread(void *) {
    while (1) {
        // LOGI("Still running here");
        fuck_you();
        sleep(20);
    }
}

__attribute__((constructor))
void init() {
    LOGE("Loaded Test");

    pthread_t t;
    pthread_create(&t, nullptr, thread, nullptr);

    //Don't leave any traces, remap the loader lib as well
    RemapTools::RemapLibrary("libRevenyInjector.so");
}