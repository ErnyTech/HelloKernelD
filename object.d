module object;

static assert((void*).sizeof == 8);

alias string = immutable(char)[];
alias size_t = uint;
alias ptrdiff_t = int;

extern(C)
void _d_run_main() {
    _Dmain();
}

extern(C) void _d_dso_registry() {}
extern(C) __gshared void* _Dmodule_ref;
extern(C) void _Dmain();

class Object { }

class Throwable {}
class Exception : Throwable {}
class Error : Throwable {}

class TypeInfo { }

class TypeInfo_Struct : TypeInfo {
        void*[15] compilerProvidedData;
}

class TypeInfo_Interface : TypeInfo {
        TypeInfo_Class info;
}

class TypeInfo_Class : TypeInfo {
        void*[17] compilerProvidedData;
}

struct ModuleInfo {}
 
