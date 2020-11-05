#pragma once

/**
 * @addtogroup utils
 * @{
 */

#ifdef SWIG
/// SWIG can't hadle "final" specifier in class definition
    #define BNB_FINAL
/// SWIG doesn't support "alignas" specifier
    #define BNB_ALIGNAS(x)
#else
    #define BNB_FINAL final
    #define BNB_ALIGNAS(x) alignas(x)
#endif

#ifdef _WIN32
    #if BNB_SDK_SHARED_LIBRARY
        #define BNB_EXPORT __declspec(dllexport)
    #elif BNB_SDK_STATIC_LIBRARY
        #define BNB_EXPORT
    #else
        #define BNB_EXPORT __declspec(dllimport)
    #endif
#else
    #define BNB_EXPORT __attribute__((__visibility__("default")))
#endif

//-----------------------

#define BNB_OS_ANDROID 0

#if !defined(BNB_DETAIL_OS_DETECTED) && (defined(__ANDROID__))
    #undef BNB_OS_ANDROID
    #define BNB_OS_ANDROID 1
#endif

#if BNB_OS_ANDROID
    #define BNB_OS_ANDROID_AVAILABLE
    #include <bnb/utils/os_detected.hpp>
#endif

//-----------------------

#define BNB_OS_IOS 0

#if !defined(BNB_DETAIL_OS_DETECTED) && (defined(__APPLE__) && defined(__MACH__) && defined(__ENVIRONMENT_IPHONE_OS_VERSION_MIN_REQUIRED__))
    #undef BNB_OS_IOS
    #define BNB_OS_IOS 1
#endif

#if BNB_OS_IOS
    #define BNB_OS_IOS_AVAILABLE
    #include <bnb/utils/os_detected.hpp>
#endif

//-----------------------

#define BNB_OS_LINUX 0

#if !defined(BNB_DETAIL_OS_DETECTED) && (defined(linux) || defined(__linux))
    #undef BNB_OS_LINUX
    #define BNB_OS_LINUX 1
#endif

#if BNB_OS_LINUX
    #define BNB_OS_LINUX_AVAILABLE
    #include <bnb/utils/os_detected.hpp>
#endif

//-----------------------

#define BNB_OS_MACOS 0

#if !defined(BNB_DETAIL_OS_DETECTED) && (defined(macintosh) || defined(Macintosh) || (defined(__APPLE__) && defined(__MACH__)))
    #undef BNB_OS_MACOS
    #define BNB_OS_MACOS 1
#endif

#if BNB_OS_MACOS
    #define BNB_OS_MACOS_AVAILABLE
    #include <bnb/utils/os_detected.hpp>
#endif

//-----------------------

#define BNB_OS_EMSCRIPTEN 0

#if !defined(BNB_DETAIL_OS_DETECTED) && defined(__EMSCRIPTEN__)
    #undef BNB_OS_EMSCRIPTEN
    #define BNB_OS_EMSCRIPTEN 1
#endif

#if BNB_OS_EMSCRIPTEN
    #define BNB_OS_EMSCRIPTEN_AVAILABLE
    #include <bnb/utils/os_detected.hpp>
#endif

//-----------------------

#define BNB_OS_UNIX 0

#if defined(unix) || defined(__unix) || defined(_XOPEN_SOURCE) || defined(_POSIX_SOURCE)
    #undef BNB_OS_UNIX
    #define BNB_OS_UNIX 1
#endif

#if BNB_OS_UNIX
    #define BNB_OS_UNIX_AVAILABLE
#endif

//-----------------------

#define BNB_OS_WINDOWS 0

#if !defined(BNB_DETAIL_OS_DETECTED) && (defined(_WIN32) || defined(_WIN64) || defined(__WIN32__) || defined(__TOS_WIN__) || defined(__WINDOWS__))
    #undef BNB_OS_WINDOWS
    #define BNB_OS_WINDOWS 1
#endif

#if BNB_OS_WINDOWS
    #define BNB_OS_WINDOWS_AVAILABLE
    #include <bnb/utils/os_detected.hpp>
#endif


//-----------------------

#define BNB_APPLE 0

#if defined(macintosh) || defined(Macintosh) || defined(__APPLE__)
    #undef BNB_APPLE
    #define BNB_APPLE 1
#endif

/** @} */ // endgroup utils
