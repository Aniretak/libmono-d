module mono;

extern (C):
nothrow:

/* jit/jit.h */

MonoDomain* mono_jit_init(const(char)* file);

MonoDomain* mono_jit_init_version(const(char)* root_domain_name,
                                  const(char)* runtime_version);

int mono_jit_exec(MonoDomain* domain,
                  MonoAssembly* assembly,
                  int argc,
                  char** argv);

void mono_jit_cleanup(MonoDomain* domain);

int mono_jit_set_trace_options(const(char)* options);

void mono_set_signal_chaining(int chain_signals);

void mono_jit_set_aot_only(int aot_only);

enum MonoBreakPolicy
{
    MONO_BREAK_POLICY_ALWAYS,
    MONO_BREAK_POLICY_NEVER,
    MONO_BREAK_POLICY_ON_DBG,
}

alias MonoBreakPolicy function(MonoMethod* method) MonoBreakPolicyFunc;

void mono_set_break_policy(MonoBreakPolicyFunc policy_callback);

void mono_jit_parse_options(int argc, char** argv);

/* utils/mono-dl-fallback.h */

enum
{
    MONO_DL_LAZY = 1,
    MONO_DL_LOCAL = 2,
    MONO_DL_MASK = 3,
}

struct MonoDlFallbackHandler
{
}

alias void* function(const(char)*, int, char**, void*) MonoDlFallbackLoad;
alias void* function(void*, const(char)*, char**, void*) MonoDlFallbackSymbol;
alias void* function(void*, void*) MonoDlFallbackClose;

MonoDlFallbackHandler* mono_dl_fallback_register(MonoDlFallbackLoad load_func,
                                                 MonoDlFallbackSymbol symbol_func,
                                                 MonoDlFallbackClose close_func,
                                                 void* user_data);

void mono_dl_fallback_unregister(MonoDlFallbackHandler* handler);

/* metadata/appdomain.h */

/* metadata/assembly.h */

/* metadata/attrdefs.h */

/* metadata/blob.h */

/* metadata/class.h */

/* metadata/debug-helpers.h */

/* metadata/debug-mono-symfile.h */

/* metadata/environment.h */

int mono_environment_exitcode_get();

void mono_environment_exitcode_set(int value);

/* metadata/exception.h */

/* metadata/image.h */

/* metadata/loader.h */

/* metadata/metadata.h */

/* metadata/mono-config.h */

const(char)* mono_get_config_dir();

void mono_set_config_dir(const(char)* dir);

const(char)* mono_get_machine_config();

void mono_config_cleanup();

void mono_config_parse(const(char)* filename);

void mono_config_for_assembly(MonoImage* assembly);

void mono_config_parse_memory(const(char)* buffer);

const(char)* mono_config_string_for_assembly_file(const(char)* filename);

/* metadata/mono-debug.h */

/* metadata/mono-gc.h */

alias int function(MonoObject*, MonoClass*, size_t, size_t, MonoObject**, size_t*, void*) MonoGCReferences;

void mono_gc_collect(int generation);

int mono_gc_max_generation();

int mono_gc_get_generation(MonoObject* object);

int mono_gc_collection_count(int generation);

long mono_gc_get_used_size();

long mono_gc_get_heap_size();

int mono_gc_invoke_finalizers();

int mono_gc_walk_heap(int flags,
                      MonoGCReferences callback,
                      void* data);

/* metadata/object.h */

/* metadata/opcodes.h */

/* metadata/profiler.h */

/* metadata/reflection.h */

/* metadata/row-indexes.h */

/* metadata/sgen-bridge.h */

/* metadata/threads.h */

/* metadata/tokentype.h */

/* metadata/verify.h */

/* utils/mono-error.h */

enum
{
    MONO_ERROR_FREE_STRINGS = 0x0001,
    MONO_ERROR_INCOMPLETE = 0x0002,
}

enum
{
    MONO_ERROR_NONE = 0,
    MONO_ERROR_MISSING_METHOD = 1,
    MONO_ERROR_MISSING_FIELD = 2,
    MONO_ERROR_TYPE_LOAD = 3,
    MONO_ERROR_FILE_NOT_FOUND = 4,
    MONO_ERROR_BAD_IMAGE = 5,
    MONO_ERROR_OUT_OF_MEMORY = 6,
    MONO_ERROR_ARGUMENT = 7,
    MONO_ERROR_NOT_VERIFIABLE = 8,
    MONO_ERROR_GENERIC = 9,
}

struct MonoError
{
    ushort error_code;
    ushort hidden_0;
    void*[12] hidden_1;
    char[128] hidden_2;
}

void mono_error_init(MonoError* error);

void mono_error_init_flags(MonoError* error,
                           ushort flags);

void mono_error_cleanup(MonoError* error);

int mono_error_ok(MonoError* error);

ushort mono_error_get_error_code(MonoError* error);

const(char)* mono_error_get_message(MonoError* error);

/* utils/mono-logger.h */

void mono_trace_set_level_string(const(char)* value);

void mono_trace_set_mask_string(const(char)* value);

/* utils/mono-publib.h */

void mono_free(void* ptr);
