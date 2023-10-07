console.log("loading frida scripts ....")

// hook libTest.so dlopen module
var libtest = Process.getModuleByName("libTest.so")

libtest.enumerateExports()
libtest.findExportByName("fuck_you")
Interceptor.attach(ptr(address), {onEnter:(args)=>{console.log("catch you")}})


// trigger hookme function in libRevenyInjector.so after remap
var myso = Process.getModuleByName("libRevenyInjector.so")
var hookme = myso.findExportByName("hookme")
var mptr = new NativeFunction(ptr(hookme), "void", [])
mptr()

