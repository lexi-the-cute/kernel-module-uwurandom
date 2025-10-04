KERNELRELEASE ?= $(shell uname -r)
#INSTALL_MOD_DIR ?= updates
KERNEL_DIR  ?= /lib/modules/${KERNELRELEASE}/build
INSTALL_DIR ?= /lib/modules/${KERNELRELEASE}/updates #${INSTALL_MOD_DIR}
EXTRA_CFLAGS += -I`pwd` -Wno-declaration-after-statement
#obj-m += uwurandom.o

usermode: CFLAGS += -O3 -std=c99
wasm: CFLAGS += -Oz -std=c99
sharedlib: CFLAGS += -O3 -std=c99 -fPIC

kernel:
	make -C ${KERNEL_DIR} M=`pwd` modules

install:
	$(shell mkdir -p ${INSTALL_DIR})
	make -C ${KERNEL_DIR} M=`pwd` modules_install

clean-kernel:
	make -C ${KERNEL_DIR} M=`pwd` clean

usermode:
	$(CC) ${CFLAGS} uwurandom_user.c -o uwurandom

clean-usermode:
	-rm --preserve-root=all --one-file-system --force uwurandom

wasm:
	clang --target=wasm32 --no-standard-libraries -Wl,--no-entry -Wl,--strip-all -Wl,--export=malloc -Wl,--export=free -Wall ${CFLAGS} -o uwurandom.wasm uwurandom_wasm.c

clean-wasm:
	-rm --preserve-root=all --one-file-system --force uwurandom.wasm

js: wasm
	cd uwurandom-js && $(MAKE)

clean-js: clean-wasm
	cd uwurandom-js && $(MAKE) clean

sharedlib:
	$(CC) ${CFLAGS} -shared -o libuwurandom.so uwurandom_lib.c

clean-sharedlib:
	-rm --preserve-root=all --one-file-system --force libuwurandom.so

all: kernel usermode wasm js sharedlib
clean: clean-usermode clean-wasm clean-js clean-sharedlib clean-kernel
