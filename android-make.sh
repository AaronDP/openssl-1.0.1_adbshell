#!/bin/sh
wget ftp://ftp.openssl.org/source/openssl-1.0.1t.tar.gz
tar xvzf openssl-1.0.1t.tar.gz
cd openssl-1.0.1t.tar.gz
export DEV_PREFIX=/opt
export ANDROID_NDK=${DEV_PREFIX}/ndk
export CROSS_COMPILE= #arm-linux-androideabi
export ANDROID_PREFIX=/tmp/chain
export SYSROOT=${ANDROID_NDK}/platforms/android-17/arch-arm
export CROSS_PATH=${ANDROID_PREFIX}/bin/arm-linux-androideabi
export CPP=${CROSS_PATH}-cpp
export AR=${CROSS_PATH}-ar
export AS=${CROSS_PATH}-as
export NM=${CROSS_PATH}-nm
export CC=${CROSS_PATH}-gcc
export CXX=${CROSS_PATH}-g++
export LD=${CROSS_PATH}-ld
export RANLIB=${CROSS_PATH}-ranlib
export PREFIX=/data/local/tmp
export PKG_CONFIG_PATH=${PREFIX}/lib/pkgconfig
#CFLAGS="-UHAVE_LOCALE_H --sysroot=${SYSROOT} -I${SYSROOT}/usr/include -I${ANDROID_PREFIX}/include -I${DEV_PREFIX}/android/bionic "
#CPPFLAGS="${CFLAGS}"
#LDFLAGS="${LDFLAGS} -L${SYSROOT}/usr/lib -L${ANDROID_PREFIX}/lib"
export ARCH_FLAGS="-march=armv7-a -mfloat-abi=softfp -mfpu=vfpv3-d16"
export ARCH_LINK="-march=armv7-a -Wl,--fix-cortex-a8"
export CFLAGS=" ${ARCH_FLAGS} -fpic -ffunction-sections -funwind-tables -fstack-protector -fno-strict-aliasing -finline-limit=64 "
export CPPFLAGS=" ${ARCH_FLAGS} -fpic -ffunction-sections -funwind-tables -fstack-protector -fno-strict-aliasing -finline-limit=64 "
export CXXFLAGS=" ${ARCH_FLAGS} -fpic -ffunction-sections -funwind-tables -fstack-protector -fno-strict-aliasing -finline-limit=64 -frtti -fexceptions "
export LDFLAGS=" ${ARCH_LINK} "
# $NDK/ndk-build 
./Configure android-armv7 shared --openssldir=/data/local/tmp/lib --prefix=/data/local/tmp && make depend && make && make install
./Configure android-armv7 no-shared --openssldir=/data/local/tmp/lib --prefix=/data/local/tmp && make depend && make && make install
cd .. && echo Done
# cp libcrypto.a /data/local/tmp/lib
# cp libssl.a /data/local/tmp/lib
# cp libcrypto.so /data/local/tmp/lib
# cp libssl.so /data/local/tmp/lib
# cp -r include/openssl /data/local/tmp/lib/include
#my $usage="Usage: Configure [no-<cipher> ...] [enable-<cipher> ...] [experimental-<cipher> ...] [-Dxxx] [-lxxx] [-Lxxx] [-fxxx] [-Kxxx] [no-hw-xxx|no-hw] [[no-]threads] [[no-]shared] [[no-]zlib|zlib-dynamic] [no-asm] [no-dso] [no-krb5] [sctp] [386] [--prefix=DIR] [--openssldir=OPENSSLDIR] [--with-xxx[=vvv]] [--test-sanity] os/compiler[:flags]\n";
#
# Options:
#
# --openssldir  install OpenSSL in OPENSSLDIR (Default: DIR/ssl if the
#               --prefix option is given; /usr/local/ssl otherwise)
# --prefix      prefix for the OpenSSL include, lib and bin directories
#               (Default: the OPENSSLDIR directory)
#
# --install_prefix  Additional prefix for package builders (empty by
#               default).  This needn't be set in advance, you can
#               just as well use "make INSTALL_PREFIX=/whatever install".
#
# --with-krb5-dir  Declare where Kerberos 5 lives.  The libraries are expected
#		to live in the subdirectory lib/ and the header files in
#		include/.  A value is required.
# --with-krb5-lib  Declare where the Kerberos 5 libraries live.  A value is
#		required.
#		(Default: KRB5_DIR/lib)
# --with-krb5-include  Declare where the Kerberos 5 header files live.  A
#		value is required.
#		(Default: KRB5_DIR/include)
# --with-krb5-flavor  Declare what flavor of Kerberos 5 is used.  Currently
#		supported values are "MIT" and "Heimdal".  A value is required.
#
# --test-sanity Make a number of sanity checks on the data in this file.
#               This is a debugging tool for OpenSSL developers.
#
# --cross-compile-prefix Add specified prefix to binutils components.
#
# no-hw-xxx     do not compile support for specific crypto hardware.
#               Generic OpenSSL-style methods relating to this support
#               are always compiled but return NULL if the hardware
#               support isn't compiled.
# no-hw         do not compile support for any crypto hardware.
# [no-]threads  [don't] try to create a library that is suitable for
#               multithreaded applications (default is "threads" if we
#               know how to do it)
# [no-]shared	[don't] try to create shared libraries when supported.
# no-asm        do not use assembler
# no-dso        do not compile in any native shared-library methods. This
#               will ensure that all methods just return NULL.
# no-krb5       do not compile in any KRB5 library or code.
# [no-]zlib     [don't] compile support for zlib compression.
# zlib-dynamic	Like "zlib", but the zlib library is expected to be a shared
#		library and will be loaded in run-time by the OpenSSL library.
# sctp          include SCTP support
# 386           generate 80386 code
# enable-weak-ssl-ciphers
#		Enable EXPORT and LOW SSLv3 ciphers that are disabled by
#		default.  Note, weak SSLv2 ciphers are unconditionally
#		disabled.
# no-sse2	disables IA-32 SSE2 code, above option implies no-sse2
# no-<cipher>   build without specified algorithm (rsa, idea, rc5, ...)
# -<xxx> +<xxx> compiler options are passed through 
#
# DEBUG_SAFESTACK use type-safe stacks to enforce type-safety on stack items
#		provided to stack calls. Generates unique stack functions for
#		each possible stack type.
# DES_PTR	use pointer lookup vs arrays in the DES in crypto/des/des_locl.h
# DES_RISC1	use different DES_ENCRYPT macro that helps reduce register
#		dependancies but needs to more registers, good for RISC CPU's
# DES_RISC2	A different RISC variant.
# DES_UNROLL	unroll the inner DES loop, sometimes helps, somtimes hinders.
# DES_INT	use 'int' instead of 'long' for DES_LONG in crypto/des/des.h
#		This is used on the DEC Alpha where long is 8 bytes
#		and int is 4
# BN_LLONG	use the type 'long long' in crypto/bn/bn.h
# MD2_CHAR	use 'char' instead of 'int' for MD2_INT in crypto/md2/md2.h
# MD2_LONG	use 'long' instead of 'int' for MD2_INT in crypto/md2/md2.h
# IDEA_SHORT	use 'short' instead of 'int' for IDEA_INT in crypto/idea/idea.h
# IDEA_LONG	use 'long' instead of 'int' for IDEA_INT in crypto/idea/idea.h
# RC2_SHORT	use 'short' instead of 'int' for RC2_INT in crypto/rc2/rc2.h
# RC2_LONG	use 'long' instead of 'int' for RC2_INT in crypto/rc2/rc2.h
# RC4_CHAR	use 'char' instead of 'int' for RC4_INT in crypto/rc4/rc4.h
# RC4_LONG	use 'long' instead of 'int' for RC4_INT in crypto/rc4/rc4.h
# RC4_INDEX	define RC4_INDEX in crypto/rc4/rc4_locl.h.  This turns on
#		array lookups instead of pointer use.
# RC4_CHUNK	enables code that handles data aligned at long (natural CPU
#		word) boundary.
# RC4_CHUNK_LL	enables code that handles data aligned at long long boundary
#		(intended for 64-bit CPUs running 32-bit OS).
# BF_PTR	use 'pointer arithmatic' for Blowfish (unsafe on Alpha).
# BF_PTR2	intel specific version (generic version is more efficient).
#
# Following are set automatically by this script
#
# MD5_ASM	use some extra md5 assember,
# SHA1_ASM	use some extra sha1 assember, must define L_ENDIAN for x86
# RMD160_ASM	use some extra ripemd160 assember,
# SHA256_ASM	sha256_block is implemented in assembler
# SHA512_ASM	sha512_block is implemented in assembler
# AES_ASM	ASE_[en|de]crypt is implemented in assembler

# Minimum warning options... any contributions to OpenSSL should at least get
