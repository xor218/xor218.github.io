---
layout: post
author: "大西瓜"
title: "pkg-config 如何使用"
date:   2024-04-30 15:07:52 +0800
categories: [update,CLanguage] 
---

## 基本用法

** pkg-config --cflags --libs 库名称**


```bash
    gcc main.c `pkg-config --cflags --libs x11`




```

pkg-config --cflags --libs x11` 列出编译的 include 路径 L 链接库的路径 和库名称
output: -I/opt/homebrew/Cellar/libx11/1.8.9/include -I/opt/homebrew/Cellar/libxcb/1.17.0/include -I/opt/homebrew/Cellar/libxau/1.0.11/include -I/opt/homebrew/Cellar/libxdmcp/1.1.5/include -I/opt/homebrew/Cellar/xorgproto/2024.1/include -L/opt/homebrew/Cellar/libx11/1.8.9/lib -lX11


pkg-config 会查找 环境变量 PKG_CONFIG_PATH 查找库的Cflag 和库的路径的 .pc文件 库名.pc   

echo $PKG_CONFIG_PATH
/usr/lib/pkgconfig:/opt/homebrew/opt/libpcap/lib/pkgconfig:/opt/homebrew/opt/jpeg/lib/pkgconfig:/opt/homebrew/opt/ruby/lib/pkgconfig



## .pc文件如何制作

假设一下文件为 mylib.pc   libname.pc
需要把mylib.pc路径 放到PKG_CONFIG_PATH 
like:`export PKG_CONFIG_PATH =/dir/of/mylib.pc/:$PKG_CONFIG_PATH`


```bash
prefix=/usr
exec_prefix=${prefix}
libdir=${exec_prefix}/lib
includedir=${prefix}/include

Name: LibraryName
Description: Description of the library
Version: 1.0.0
Libs: -L${libdir} -llibraryname
Cflags: -I${includedir}/libraryname
```

在这个示例中：

prefix，exec_prefix，libdir和includedir变量用于定义库文件和头文件的位置。
Name字段是库的名称。
Description字段是库的描述。
Version字段是库的版本号。
Libs字段是链接库时需要的标志。-L${libdir}指定库文件的位置，-llibraryname指定库的名称。
Cflags字段是编译源文件时需要的标志。-I${includedir}/libraryname指定头文件的位置。


## 列出pkg-config 所有可以查找库和

`pkg-config --list-all`


```bash
## pkg-config 显示全部库

```bash
pkg-config --list-all
```



ImageMagick                 ImageMagick - ImageMagick - convert, edit, and compose images (ABI Q16HDRI)

ImageMagick-7.Q16HDRI            ImageMagick - ImageMagick - convert, edit, and compose images (ABI Q16HDRI)

Imath                      Imath - Imath 库：向量/矩阵和数学运算，以及半类型 Imath - Imath library: vector/matrix and math operations, plus the half type.

Magick++                  Magick++ - Magick++ - C++ API for ImageMagick (ABI Q16HDRI)

Magick++-7.Q16HDRI             Magick++ - Magick++ - C++ API for ImageMagick (ABI Q16HDRI)

MagickCore                 魔力核心 MagickCore - MagickCore - C API for ImageMagick (ABI Q16HDRI)

MagickCore-7.Q16HDRI            MagickCore - MagickCore - C API for ImageMagick (ABI Q16HDRI)

MagickWand                 MagickWand - MagickWand - C API for ImageMagick (ABI Q16HDRI)

MagickWand-7.Q16HDRI            MagickWand - MagickWand - C API for ImageMagick (ABI Q16HDRI)

OpenEXR                   OpenEXR - OpenEXR image library

absl_absl_check               absl_absl_check - Abseil absl_check library

absl_absl_log                absl_absl_log - Abseil absl_log library

absl_algorithm               absl_algorithm - Abseil algorithm library

absl_algorithm_container          absl_algorithm_container - Abseil algorithm_container library

absl_any                  absl_any - Abseil any library

absl_any_invocable             absl_any_invocable - Abseil any_invocable library

absl_atomic_hook              absl_atomic_hook - Abseil atomic_hook library

absl_bad_any_cast              absl_bad_any_cast - Abseil bad_any_cast library

absl_bad_any_cast_impl           absl_bad_any_cast_impl - Abseil bad_any_cast_impl library

absl_bad_optional_access          absl_bad_optional_access - Abseil bad_optional_access library

absl_bad_variant_access           absl_bad_variant_access - Abseil bad_variant_access library

absl_base                  absl_base - Abseil base library

absl_base_internal             absl_base_internal - Abseil base_internal library

absl_bind_front               absl_bind_front - Abseil bind_front library

absl_bits                  absl_bits - Abseil bits library

absl_btree                 absl_btree - Abseil btree library

absl_check                 absl_check - Abseil check library

absl_city                  absl_city - Abseil city library

absl_civil_time               absl_civil_time - Abseil civil_time library

absl_cleanup                absl_cleanup - Abseil cleanup library

absl_cleanup_internal            absl_cleanup_internal - Abseil cleanup_internal library

absl_common_policy_traits          absl_common_policy_traits - Abseil common_policy_traits library

absl_compare                absl_compare - Abseil compare library

absl_compressed_tuple            absl_compressed_tuple - Abseil compressed_tuple library

absl_config                 absl_config - Abseil config library

absl_container_common            absl_container_common - Abseil container_common library

absl_container_memory            absl_container_memory - Abseil container_memory library

absl_cord                  absl_cord - Abseil cord library

absl_cord_internal             absl_cord_internal - Abseil cord_internal library

absl_cord_test_helpers           absl_cord_test_helpers - Abseil cord_test_helpers library

absl_cordz_functions            absl_cordz_functions - Abseil cordz_functions library

absl_cordz_handle              absl_cordz_handle - Abseil cordz_handle library

absl_cordz_info               absl_cordz_info - Abseil cordz_info library

absl_cordz_sample_token           absl_cordz_sample_token - Abseil cordz_sample_token library

absl_cordz_statistics            absl_cordz_statistics - Abseil cordz_statistics library

absl_cordz_update_scope           absl_cordz_update_scope - Abseil cordz_update_scope library

absl_cordz_update_tracker          absl_cordz_update_tracker - Abseil cordz_update_tracker library

absl_core_headers              absl_core_headers - Abseil core_headers library

absl_counting_allocator           absl_counting_allocator - Abseil counting_allocator library

absl_crc32c                 absl_crc32c - Abseil crc32c library

absl_crc_cord_state             absl_crc_cord_state - Abseil crc_cord_state library

absl_crc_cpu_detect             absl_crc_cpu_detect - Abseil crc_cpu_detect library

absl_crc_internal              absl_crc_internal - Abseil crc_internal library

absl_debugging               absl_debugging - Abseil debugging library

absl_debugging_internal           absl_debugging_internal - Abseil debugging_internal library

absl_demangle_internal           absl_demangle_internal - Abseil demangle_internal library

absl_die_if_null              absl_die_if_null - Abseil die_if_null library

absl_dynamic_annotations          absl_dynamic_annotations - Abseil dynamic_annotations library

absl_endian                 absl_endian - Abseil endian library

absl_errno_saver              absl_errno_saver - Abseil errno_saver library

absl_examine_stack             absl_examine_stack - Abseil examine_stack library

absl_exponential_biased           absl_exponential_biased - Abseil exponential_biased library

absl_failure_signal_handler         absl_failure_signal_handler - Abseil failure_signal_handler library

absl_fast_type_id              absl_fast_type_id - Abseil fast_type_id library

absl_fixed_array              absl_fixed_array - Abseil fixed_array library

absl_flags                 absl_flags - Abseil flags library

absl_flags_commandlineflag         absl_flags_commandlineflag - Abseil flags_commandlineflag library

absl_flags_commandlineflag_internal     absl_flags_commandlineflag_internal - Abseil flags_commandlineflag_internal library

absl_flags_config              absl_flags_config - Abseil flags_config library

absl_flags_internal             absl_flags_internal - Abseil flags_internal library

absl_flags_marshalling           absl_flags_marshalling - Abseil flags_marshalling library

absl_flags_parse              absl_flags_parse - Abseil flags_parse library

absl_flags_path_util            absl_flags_path_util - Abseil flags_path_util library

absl_flags_private_handle_accessor     absl_flags_private_handle_accessor - Abseil flags_private_handle_accessor library

absl_flags_program_name           absl_flags_program_name - Abseil flags_program_name library

absl_flags_reflection            absl_flags_reflection - Abseil flags_reflection library

absl_flags_usage              absl_flags_usage - Abseil flags_usage library

absl_flags_usage_internal          absl_flags_usage_internal - Abseil flags_usage_internal library

absl_flat_hash_map             absl_flat_hash_map - Abseil flat_hash_map library

absl_flat_hash_set             absl_flat_hash_set - Abseil flat_hash_set library

absl_function_ref              absl_function_ref - Abseil function_ref library

absl_graphcycles_internal          absl_graphcycles_internal - Abseil graphcycles_internal library

absl_hash                  absl_hash - Abseil hash library

absl_hash_function_defaults         absl_hash_function_defaults - Abseil hash_function_defaults library

absl_hash_policy_traits           absl_hash_policy_traits - Abseil hash_policy_traits library

absl_hash_testing              absl_hash_testing - Abseil hash_testing library

absl_hashtable_debug            absl_hashtable_debug - Abseil hashtable_debug library

absl_hashtable_debug_hooks         absl_hashtable_debug_hooks - Abseil hashtable_debug_hooks library

absl_hashtablez_sampler           absl_hashtablez_sampler - Abseil hashtablez_sampler library

absl_if_constexpr              absl_if_constexpr - Abseil if_constexpr library

absl_inlined_vector             absl_inlined_vector - Abseil inlined_vector library

absl_inlined_vector_internal        absl_inlined_vector_internal - Abseil inlined_vector_internal library

absl_int128                 absl_int128 - Abseil int128 library

absl_kernel_timeout_internal        absl_kernel_timeout_internal - Abseil kernel_timeout_internal library

absl_layout                 absl_layout - Abseil layout library

absl_leak_check               absl_leak_check - Abseil leak_check library

absl_log                  absl_log - Abseil log library

absl_log_entry               absl_log_entry - Abseil log_entry library

absl_log_flags               absl_log_flags - Abseil log_flags library

absl_log_globals              absl_log_globals - Abseil log_globals library

absl_log_initialize             absl_log_initialize - Abseil log_initialize library

absl_log_internal_append_truncated     absl_log_internal_append_truncated - Abseil log_internal_append_truncated library

absl_log_internal_check_impl        absl_log_internal_check_impl - Abseil log_internal_check_impl library

absl_log_internal_check_op         absl_log_internal_check_op - Abseil log_internal_check_op library

absl_log_internal_conditions        absl_log_internal_conditions - Abseil log_internal_conditions library

absl_log_internal_config          absl_log_internal_config - Abseil log_internal_config library

absl_log_internal_flags           absl_log_internal_flags - Abseil log_internal_flags library

absl_log_internal_format          absl_log_internal_format - Abseil log_internal_format library

absl_log_internal_globals          absl_log_internal_globals - Abseil log_internal_globals library

absl_log_internal_log_impl         absl_log_internal_log_impl - Abseil log_internal_log_impl library

absl_log_internal_log_sink_set       absl_log_internal_log_sink_set - Abseil log_internal_log_sink_set library

absl_log_internal_message          absl_log_internal_message - Abseil log_internal_message library

absl_log_internal_nullguard         absl_log_internal_nullguard - Abseil log_internal_nullguard library

absl_log_internal_nullstream        absl_log_internal_nullstream - Abseil log_internal_nullstream library

absl_log_internal_proto           absl_log_internal_proto - Abseil log_internal_proto library

absl_log_internal_strip           absl_log_internal_strip - Abseil log_internal_strip library

absl_log_internal_structured        absl_log_internal_structured - Abseil log_internal_structured library

absl_log_internal_voidify          absl_log_internal_voidify - Abseil log_internal_voidify library

absl_log_severity              absl_log_severity - Abseil log_severity library

absl_log_sink                absl_log_sink - Abseil log_sink library

absl_log_sink_registry           absl_log_sink_registry - Abseil log_sink_registry library

absl_log_streamer              absl_log_streamer - Abseil log_streamer library

absl_log_structured             absl_log_structured - Abseil log_structured library

absl_low_level_hash             absl_low_level_hash - Abseil low_level_hash library

absl_malloc_internal            absl_malloc_internal - Abseil malloc_internal library

absl_memory                 absl_memory - Abseil memory library

absl_meta                  absl_meta - Abseil meta library

absl_node_hash_map             absl_node_hash_map - Abseil node_hash_map library

absl_node_hash_set             absl_node_hash_set - Abseil node_hash_set library

absl_node_slot_policy            absl_node_slot_policy - Abseil node_slot_policy library

absl_non_temporal_arm_intrinsics      absl_non_temporal_arm_intrinsics - Abseil non_temporal_arm_intrinsics library

absl_non_temporal_memcpy          absl_non_temporal_memcpy - Abseil non_temporal_memcpy library

absl_nullability              absl_nullability - Abseil nullability library

absl_numeric                absl_numeric - Abseil numeric library

absl_numeric_representation         absl_numeric_representation - Abseil numeric_representation library

absl_optional                absl_optional - Abseil optional library

absl_periodic_sampler            absl_periodic_sampler - Abseil periodic_sampler library

absl_prefetch                absl_prefetch - Abseil prefetch library

absl_pretty_function            absl_pretty_function - Abseil pretty_function library

absl_random_bit_gen_ref           absl_random_bit_gen_ref - Abseil random_bit_gen_ref library

absl_random_distributions          absl_random_distributions - Abseil random_distributions library

absl_random_internal_distribution_caller  absl_random_internal_distribution_caller - Abseil random_internal_distribution_caller library

absl_random_internal_distribution_test_util absl_random_internal_distribution_test_util - Abseil random_internal_distribution_test_util library

absl_random_internal_fast_uniform_bits   absl_random_internal_fast_uniform_bits - Abseil random_internal_fast_uniform_bits library

absl_random_internal_fastmath        absl_random_internal_fastmath - Abseil random_internal_fastmath library

absl_random_internal_generate_real     absl_random_internal_generate_real - Abseil random_internal_generate_real library

absl_random_internal_iostream_state_saver  absl_random_internal_iostream_state_saver - Abseil random_internal_iostream_state_saver library

absl_random_internal_mock_helpers      absl_random_internal_mock_helpers - Abseil random_internal_mock_helpers library

absl_random_internal_nonsecure_base     absl_random_internal_nonsecure_base - Abseil random_internal_nonsecure_base library

absl_random_internal_pcg_engine       absl_random_internal_pcg_engine - Abseil random_internal_pcg_engine library

absl_random_internal_platform        absl_random_internal_platform - Abseil random_internal_platform library

absl_random_internal_pool_urbg       absl_random_internal_pool_urbg - Abseil random_internal_pool_urbg library

absl_random_internal_randen         absl_random_internal_randen - Abseil random_internal_randen library

absl_random_internal_randen_engine     absl_random_internal_randen_engine - Abseil random_internal_randen_engine library

absl_random_internal_randen_hwaes      absl_random_internal_randen_hwaes - Abseil random_internal_randen_hwaes library

absl_random_internal_randen_hwaes_impl   absl_random_internal_randen_hwaes_impl - Abseil random_internal_randen_hwaes_impl library

absl_random_internal_randen_slow      absl_random_internal_randen_slow - Abseil random_internal_randen_slow library

absl_random_internal_salted_seed_seq    absl_random_internal_salted_seed_seq - Abseil random_internal_salted_seed_seq library

absl_random_internal_seed_material     absl_random_internal_seed_material - Abseil random_internal_seed_material library

absl_random_internal_traits         absl_random_internal_traits - Abseil random_internal_traits library

absl_random_internal_uniform_helper     absl_random_internal_uniform_helper - Abseil random_internal_uniform_helper library

absl_random_internal_wide_multiply     absl_random_internal_wide_multiply - Abseil random_internal_wide_multiply library

absl_random_mocking_bit_gen         absl_random_mocking_bit_gen - Abseil random_mocking_bit_gen library

absl_random_random             absl_random_random - Abseil random_random library

absl_random_seed_gen_exception       absl_random_seed_gen_exception - Abseil random_seed_gen_exception library

absl_random_seed_sequences         absl_random_seed_sequences - Abseil random_seed_sequences library

absl_raw_hash_map              absl_raw_hash_map - Abseil raw_hash_map library

absl_raw_hash_set              absl_raw_hash_set - Abseil raw_hash_set library

absl_raw_logging_internal          absl_raw_logging_internal - Abseil raw_logging_internal library

absl_sample_recorder            absl_sample_recorder - Abseil sample_recorder library

absl_scoped_mock_log            absl_scoped_mock_log - Abseil scoped_mock_log library

absl_scoped_set_env             absl_scoped_set_env - Abseil scoped_set_env library

absl_span                  absl_span - Abseil span library

absl_spinlock_wait             absl_spinlock_wait - Abseil spinlock_wait library

absl_spy_hash_state             absl_spy_hash_state - Abseil spy_hash_state library

absl_stacktrace               absl_stacktrace - Abseil stacktrace library

absl_status                 absl_status - Abseil status library

absl_statusor                absl_statusor - Abseil statusor library

absl_str_format               absl_str_format - Abseil str_format library

absl_str_format_internal          absl_str_format_internal - Abseil str_format_internal library

absl_strerror                absl_strerror - Abseil strerror library

absl_string_view              absl_string_view - Abseil string_view library

absl_strings                absl_strings - Abseil strings library

absl_strings_internal            absl_strings_internal - Abseil strings_internal library

absl_symbolize               absl_symbolize - Abseil symbolize library

absl_synchronization            absl_synchronization - Abseil synchronization library

absl_throw_delegate             absl_throw_delegate - Abseil throw_delegate library

absl_time                  absl_time - Abseil time library

absl_time_zone               absl_time_zone - Abseil time_zone library

absl_type_traits              absl_type_traits - Abseil type_traits library

absl_utility                absl_utility - Abseil utility library

absl_variant                absl_variant - Abseil variant library

aom                     aom - Alliance for Open Media AV1 codec library v3.8.1.

applewmproto                AppleWMProto - AppleWM extension headers

apr-1                    APR - The Apache Portable Runtime library

apr-util-1                 APR Utils - Companion library for APR

atk                     Atk - Accessibility Toolkit

atk-bridge-2.0               atk-bridge-2.0 - ATK/D-Bus Bridge

atspi-2                   atspi - Accessibility Technology software library

augeas                   augeas - Augeas configuration editing library

bigreqsproto                BigReqsProto - BigReqs extension headers

cairo                    cairo - Multi-platform 2D graphics library

cairo-fc                  cairo-fc - Fontconfig font backend for cairo graphics library

cairo-ft                  cairo-ft - FreeType font backend for cairo graphics library

cairo-gobject                cairo-gobject - cairo-gobject for cairo graphics library

cairo-pdf                  cairo-pdf - PDF surface backend for cairo graphics library

cairo-png                  cairo-png - PNG functions for cairo graphics library

cairo-ps                  cairo-ps - PostScript surface backend for cairo graphics library

cairo-quartz                cairo-quartz - Quartz surface backend for cairo graphics library

cairo-quartz-font              cairo-quartz-font - Quartz font backend for cairo graphics library

cairo-quartz-image             cairo-quartz-image - Quartz Image surface backend for cairo graphics library

cairo-script                cairo-script - script surface backend for cairo graphics library

cairo-script-interpreter          cairo-script-interpreter - script surface backend for cairo graphics library

cairo-svg                  cairo-svg - SVG surface backend for cairo graphics library

cairo-tee                  cairo-tee - Tee surface backend for cairo graphics library

cairo-xcb                  cairo-xcb - XCB surface backend for cairo graphics library

cairo-xcb-shm                cairo-xcb-shm - XCB/SHM functions for cairo graphics library

cairo-xlib                 cairo-xlib - Xlib surface backend for cairo graphics library

cairo-xlib-xrender             cairo-xlib-xrender - Xlib Xrender surface backend for cairo graphics library

capstone                  capstone - Capstone disassembly engine

compositeproto               CompositeExt - Composite extension headers

damageproto                 DamageProto - Damage extension headers

dbus-1                   dbus - Free desktop message bus

dmxproto                  DMXProto - DMX extension headers

dpmsproto                  DPMSProto - DPMS extension headers

dri2proto                  DRI2Proto - DRI2 extension headers

dri3proto                  DRI3Proto - DRI3 extension headers

epoxy                    epoxy - GL dispatch library

expat                    expat - expat XML parser

fixesproto                 FixesProto - X Fixes extension headers

fmt                     fmt - A modern formatting library

fontconfig                 Fontconfig - Font configuration and customization library

fontsproto                 FontsProto - Fonts extension headers

freetype2                  FreeType 2 - A free, high-quality, and portable font engine.

fribidi                   GNU FriBidi - Unicode Bidirectional Algorithm Library

gail-3.0                  Gail - GNOME Accessibility Implementation Library

gdk-3.0                   GDK - GTK+ Drawing Kit

gdk-pixbuf-2.0               GdkPixbuf - Image loading and scaling

gdk-quartz-3.0               GDK - GTK+ Drawing Kit

gio-2.0                   GIO - glib I/O library

gio-unix-2.0                GIO unix specific APIs - unix specific headers for glib I/O library

glib-2.0                  GLib - C Utility Library

glproto                   GLProto - GL extension headers

gmodule-2.0                 GModule - Dynamic module loader for GLib

gmodule-export-2.0             GModule - Dynamic module loader for GLib

gmodule-no-export-2.0            GModule - Dynamic module loader for GLib

gmp                     GNU MP - GNU Multiple Precision Arithmetic Library

gmpxx                    GNU MP C++ - GNU Multiple Precision Arithmetic Library (C++ bindings)

gnutls                   GnuTLS - Transport Security Layer implementation for the GNU system

gnutls-dane                 GnuTLS-DANE - DANE security library for the GNU system

gobject-2.0                 GObject - GLib Type, Object, Parameter and Signal Library

gpr                     gpr - gRPC platform support library

graphite2                  Graphite2 - Font rendering engine for Complex Scripts

grpc                    gRPC - high performance general RPC framework

grpc++                   gRPC++ - C++ wrapper for gRPC

grpc++_unsecure               gRPC++ unsecure - C++ wrapper for gRPC without SSL

grpc_unsecure                gRPC unsecure - high performance general RPC framework without SSL

gsettings-desktop-schemas          gsettings-desktop-schemas - Shared GSettings schemas for the desktop, including helper headers

gthread-2.0                 GThread - Thread support for GLib

gtk+-3.0                  GTK+ - GTK+ Graphical UI Library

gtk+-quartz-3.0               GTK+ - GTK+ Graphical UI Library

gtk+-unix-print-3.0             GTK+ - GTK+ Unix print support

harfbuzz                  harfbuzz - HarfBuzz text shaping library

harfbuzz-cairo               harfbuzz-cairo - HarfBuzz cairo support

harfbuzz-gobject              harfbuzz-gobject - HarfBuzz text shaping library GObject integration

harfbuzz-icu                harfbuzz-icu - HarfBuzz text shaping library ICU integration

harfbuzz-subset               harfbuzz-subset - HarfBuzz font subsetter

hogweed                   Hogweed - Nettle low-level cryptographic library (public-key algorithms)

inputproto                 InputProto - Input extension headers

jansson                   Jansson - Library for encoding, decoding and manipulating JSON data

jasper                   JasPer - Image Processing/Coding Tool Kit with JPEG-2000 Support

jbig2dec                  libjbig2dec - JBIG2 decoder library.

jsoncpp                   jsoncpp - A C++ library for interacting with JSON

kbproto                   KBProto - KB extension headers

lcms2                    lcms2 - LCMS Color Management Library

libbrotlicommon               libbrotlicommon - Brotli common dictionary library

libbrotlidec                libbrotlidec - Brotli decoder library

libbrotlienc                libbrotlienc - Brotli encoder library

libcares                  c-ares - asynchronous DNS lookup library

libcbor                   libcbor - libcbor - CBOR protocol implementation

libcrypto                  OpenSSL-libcrypto - OpenSSL 密码库 OpenSSL-libcrypto - OpenSSL cryptography library

libcurl                    libcurl - 用于使用 ftp、http 等传输文件的库。 libcurl - Library to transfer files with ftp, http, etc.

libde265                  libde265 - H.265/HEVC video decoder.

libedit                   libedit - command line editor library provides generic line editing, history, and tokenization functions.

libevent                  libevent - libevent 是一个异步通知事件循环库 libevent - libevent is an asynchronous notification event loop library

libevent_core                libevent_core - libevent_core

libevent_extra               libevent_extra - libevent_extra

libevent_openssl              libevent_openssl - libevent_openssl adds openssl-based TLS support to libevent

libevent_pthreads              libevent_pthreads - libevent_pthreads adds pthreads-based threading support to libevent

libexslt                  libexslt - EXSLT Extension library

libffi                   libffi - Library supporting Foreign Function Interfaces

libfido2                  libfido2 - A FIDO2 library

libheif                    libheif - HEIF 图像编解码器。 libheif - HEIF image codec.

libhwy                   libhwy - Efficient and performance-portable SIMD wrapper

libhwy-contrib               libhwy-contrib - Additions to Highway: dot product, image, math, sort

libidn                   Libidn - IETF stringprep, nameprep, punycode, IDNA text processing.

libidn2                   libidn2 - Library implementing IDNA2008 and TR46

libiodbc                  iODBC - iODBC Driver Manager

libjpeg                   libjpeg - A SIMD-accelerated JPEG codec that provides the libjpeg API

libjq                    libjq - Library to process JSON using a query language

libjxl                   libjxl - Loads and saves JPEG XL files

libjxl_cms                 libjxl_cms - CMS support library for libjxl

libjxl_threads               libjxl_threads - JPEG XL multi-thread runner using std::threads.

libluv                   libluv - Bare and full libuv bindings for Lua/LuaJIT.

liblz4                   lz4 - extremely fast lossless compression algorithm library

liblzma                   liblzma - General purpose data compression library

libnghttp2                 libnghttp2 - HTTP/2 C library

libopenjp2                 openjp2 - JPEG2000 library (Part 1 and 2)

libpcap                   libpcap - Platform-independent network traffic capture library

libpcre                   libpcre - PCRE - Perl compatible regular expressions C library with 8 bit character support

libpcre16                  libpcre16 - PCRE - Perl compatible regular expressions C library with 16 bit character support

libpcre2-16                 libpcre2-16 - PCRE2 - Perl compatible regular expressions C library (2nd API) with 16 bit character support

libpcre2-32                 libpcre2-32 - PCRE2 - Perl compatible regular expressions C library (2nd API) with 32 bit character support

libpcre2-8                 libpcre2-8 - PCRE2 - Perl compatible regular expressions C library (2nd API) with 8 bit character support

libpcre2-posix               libpcre2-posix - Posix compatible interface to libpcre2-8

libpcre32                  libpcre32 - PCRE - Perl compatible regular expressions C library with 32 bit character support

libpcrecpp                 libpcrecpp - PCRECPP - C++ wrapper for PCRE

libpcreposix                libpcreposix - PCREPosix - Posix compatible interface to libpcre

libpng                   libpng - Loads and saves PNG files

libpng16                  libpng - Loads and saves PNG files

libraw                   libraw - 原始图像解码器库（非线程安全） libraw - Raw image decoder library (non-thread-safe)

libraw_r                  libraw - 原始图像解码器库（线程安全）

librtmp                   librtmp - RTMP implementation

libsharpyuv                 libsharpyuv - Library for sharp RGB to YUV conversion

libssh                   libssh - The SSH Library

libssh2                   libssh2 - Library for SSH-based communication

libssl                   OpenSSL-libssl - Secure Sockets Layer and cryptography libraries

libtasn1                  libtasn1 - Library for ASN.1 and DER manipulation

libtiff-4                  libtiff - Tag Image File Format (TIFF) library.

libturbojpeg                libturbojpeg - A SIMD-accelerated JPEG codec that provides the TurboJPEG API

libunbound                 unbound - Library with validating, recursive, and caching DNS resolver

libusb-1.0                 libusb-1.0 - C API for USB device access from Linux, Mac OS X, Windows, OpenBSD/NetBSD and Solaris userspace

libutf8proc                 libutf8proc - UTF8 processing

libuv                    libuv - multi-platform support library with a focus on asynchronous I/O.

libvmaf                   libvmaf - VMAF, Video Multimethod Assessment Fusion

libwebp                   libwebp - Library for the WebP graphics format

libwebpdecoder               libwebpdecoder - Library for the WebP graphics format (decode only)

libwebpdemux                libwebpdemux - Library for parsing the WebP graphics format container

libwebpmux                 libwebpmux - Library for manipulating the WebP graphics format container

libxml-2.0                 libXML - libXML library version2.

libxslt                   libxslt - XSLT library version 2.

libzstd                   zstd - fast lossless compression algorithm library

lqr-1                    lqr-1 - LiquidRescale seam-carving library

lua                     Lua - An Extensible Extension Language

lua-5.4                   Lua - An Extensible Extension Language

lua5.4                   Lua - An Extensible Extension Language

luajit                   LuaJIT - Just-in-time compiler for Lua

lzo2                    lzo2 - LZO - a real-time data compression library

mpfr                    mpfr - C library for multiple-precision floating-point computations

msgpack-c                  MessagePack - Binary-based efficient object serialization library

mysqlclient                 mysqlclient - MySQL client library

ncurses                   ncurses - ncurses 6.0 library

ncursesw                  ncursesw - ncurses 6.0 library

netpbm                   Netpbm - Graphics utilities

nettle                   Nettle - Nettle low-level cryptographic library (symmetric algorithms)

nlohmann_json                nlohmann_json - JSON for Modern C++

oniguruma                  oniguruma - Regular expression library

openssl                   OpenSSL - Secure Sockets Layer and cryptography libraries and tools

p11-kit-1                  p11-kit - Library and proxy module for properly loading and sharing PKCS

pango                    Pango - Internationalized text handling

pangocairo                 Pango Cairo - Cairo rendering support for Pango

pangofc                   Pango FC - Fontconfig support for Pango

pangoft2                  Pango FT2 and Pango Fc - Freetype 2.0 and fontconfig font support for Pango

pangoot                   Pango OT - OpenType font support for Pango (deprecated)

pixman-1                  Pixman - The pixman library (version 1)

portaudio-2.0                PortAudio - Portable audio I/O

portaudiocpp                PortAudioCpp - Portable audio I/O C++ bindings

presentproto                PresentProto - Present extension headers

protobuf                  Protocol Buffers - Google's Data Interchange Format

protobuf-lite                Protocol Buffers - Google's Data Interchange Format

python-3.11                 Python - Build a C extension for Python

python-3.11-embed              Python - Embed Python into an application

python-3.12                 Python - Build a C extension for Python

python-3.12-embed              Python - Embed Python into an application

python3                   Python - Build a C extension for Python

python3-embed                Python - Embed Python into an application

randrproto                 RandrProto - Randr extension headers

re2                     re2 - RE2 is a fast, safe, thread-friendly regular expression engine.

recordproto                 RecordProto - Record extension headers

renderproto                 RenderProto - Render extension headers

resourceproto                ResourceProto - Resource extension headers

scrnsaverproto               ScrnSaverProto - ScrnSaver extension headers

sdl2                    sdl2 - Simple DirectMedia Layer is a cross-platform multimedia library designed to provide low level access to audio, keyboard, mouse, joystick, 3D hardware via OpenGL, and 2D video framebuffer.

shared-mime-info              shared-mime-info - Freedesktop common MIME database

slirp                    slirp - User-space network stack

spdlog                   libspdlog - Fast C++ logging library.

sqlite3                   SQLite - SQL database engine

tcl                     Tool Command Language - Tcl is a powerful, easy-to-learn dynamic programming language, suitable for a wide range of uses.

termkey                   termkey - Abstract terminal key input library

tidy                    tidy - tidy - HTML syntax checker

`tk `                     Tk 工具包 - Tk 是一个跨平台图形用户界面工具包，不仅是 Tcl 的标准图形用户界面，也是许多其他动态语言的标准图形用户界面。 The Tk Toolkit - Tk is a cross-platform graphical user interface toolkit, the standard GUI not only for Tcl, but for many other dynamic languages as well.

tree-sitter                 tree-sitter - An incremental parsing system for programming tools

uchardet                  uchardet - An encoding detector library ported from Mozilla

unibilium                  unibilium - terminfo parser and utility functions

utf8_range                 UTF8 Range - Google's UTF8 Library

uuid                    uuid - Universally unique id library

vdehist                   vdehist - A library to manage history and command completion for vde mgmt protocol

vdemgmt                   vdemgmt - Virtual Distributed Ethernet console management library.

vdeplug                   vdeplug - Virtual Distributed Ethernet connection library.

vdesnmp                   vdesnmp - SNMP library for Virtual Distributed Ethernet.

videoproto                 VideoProto - Video extension headers

vterm                    vterm - Abstract VT220/Xterm/ECMA-48 emulation library

x11                     X11 - X Library

x11-xcb                   X11 XCB - X Library XCB interface

x265                     x265 - H.265/HEVC 视频编码器 x265 - H.265/HEVC video encoder

xau                     Xau - X authorization file management library

xcb                     XCB - X-protocol C Binding

xcb-composite                XCB Composite - XCB Composite Extension

xcb-damage                 XCB Damage - XCB Damage Extension

xcb-dbe                   XCB Dbe - XCB Double Buffer Extension

xcb-dpms                  XCB DPMS - XCB DPMS Extension

xcb-dri2                  XCB DRI2 - XCB DRI2 Extension

xcb-dri3                  XCB DRI3 - XCB DRI3 Extension

xcb-ge                   XCB GenericEvent - XCB GenericEvent Extension

xcb-glx                   XCB GLX - XCB GLX Extension

xcb-present                 XCB Present - XCB Present Extension

xcb-randr                  XCB RandR - XCB RandR Extension

xcb-record                 XCB Record - XCB Record Extension

xcb-render                 XCB Render - XCB Render Extension

xcb-res                   XCB Res - XCB X-Resource Extension

xcb-screensaver               XCB Screensaver - XCB Screensaver Extension

xcb-shape                  XCB Shape - XCB Shape Extension

xcb-shm                   XCB Shm - XCB Shm Extension

xcb-sync                  XCB Sync - XCB Sync Extension

xcb-xevie                  XCB Xevie - XCB Xevie Extension

xcb-xf86dri                 XCB XFree86-DRI - XCB XFree86-DRI Extension

xcb-xfixes                 XCB XFixes - XCB XFixes Extension

xcb-xinerama                XCB Xinerama - XCB Xinerama Extension

xcb-xinput                 XCB XInput - XCB XInput Extension (EXPERIMENTAL)

xcb-xkb                   XCB XKB - XCB Keyboard Extension (EXPERIMENTAL)

xcb-xprint                 XCB Xprint - XCB Xprint Extension

xcb-xselinux                XCB SELinux - XCB SELinux Extension

xcb-xtest                  XCB XTEST - XCB XTEST Extension

xcb-xv                   XCB Xv - XCB Xv Extension

xcb-xvmc                  XCB XvMC - XCB XvMC Extension

xcmiscproto                 XCMiscProto - XCMisc extension headers

xdmcp                    Xdmcp - X Display Manager Control Protocol library

xext                    Xext - Misc X Extension Library

xextproto                  XExtProto - XExt extension headers

xf86bigfontproto              XF86BigFontProto - XF86BigFont extension headers

xf86dgaproto                XF86DGAProto - XF86DGA extension headers

xf86driproto                XF86DRIProto - XF86DRI extension headers

xf86vidmodeproto              XF86VidModeProto - XF86VidMode extension headers

xfixes                   Xfixes - X Fixes Library

xi                     Xi - X Input Extension Library

xineramaproto                XineramaProto - Xinerama extension headers

xproto                   Xproto - Xproto headers

xrender                   Xrender - X Render Library

xtst                    Xtst - The Xtst Library

xwaylandproto                XwaylandProto - Xwayland extension headers

zlib                    zlib - zlib compression library

```