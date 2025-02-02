
ARGS         :=
BUILD_SCRIPT := build.sh
KERNEL       := zen
SHARE_OPTION := --boot-splash --comp-type "xz" --user "uhuru" --password "uhuru" --kernel "${KERNEL}" --noconfirm
ARCH_x86_64  := --arch x86_64
ARCH_i686    := --arch i686
ARCH_Pen4    := --arch pen4
FULLBUILD    := -d -g -e -r 5 --noconfirm
DEBUG_OPTION := --debug --log
DEBUG        := false
#FULL_x86_64  := xfce cinnamon i3 plasma gnome
FULL_x86_64  := xfce i3 plasma
FULL_i686    := xfce lxde
FULL_Pen4    := xfce lxde

CURRENT_DIR  := ${shell dirname $(dir $(abspath $(lastword $(MAKEFILE_LIST))))}/${shell basename $(dir $(abspath $(lastword $(MAKEFILE_LIST))))}

ifeq (${DEBUG},true)
	ARGS += ${ARGS} ${DEBUG_OPTION}
endif

full: full-x86_64 full-i686 clean

full-x86_64:
	sudo ${CURRENT_DIR}/tools/fullbuild.sh ${FULLBUILD} -m x86_64 ${FULL_x86_64}

full-i686:
	sudo ${CURRENT_DIR}/tools/fullbuild.sh ${FULLBUILD} -m i686   ${FULL_i686}

full-pen4:
	sudo ${CURRENT_DIR}/tools/fullbuild.sh ${FULLBUILD} -m pen4   ${FULL_Pen4}

basic-ja-64    basic-en-64    basic-ja-32     basic-en-32     basic-ja-pen4     basic-en-pen4    \
cinnamon-ja-64 cinnamon-en-64 cinnamon-ja-32  cinnamon-en-32  cinnamon-ja-pen4  cinnamon-en-pen4 \
gnome-ja-64    gnome-en-64    gnome-ja-32     gnome-en-32     gnome-ja-pen4     gnome-en-pen4    \
i3-ja-64       i3-en-64       i3-ja-32        i3-en-32        i3-ja-pen4        i3-en-pen4       \
lxde-ja-64     lxde-en-64     lxde-ja-32      lxde-en-32      lxde-ja-pen4      lxde-en-pen4     \
plasma-ja-64   plasma-en-64                                                                      \
releng-ja-64   releng-en-64   releng-ja-32    releng-en-32    releng-ja-pen4    releng-en-pen4   \
serene-ja-64   serene-en-64   serene-ja-32    serene-en-32    serene-ja-pen4    serene-en-pen4   \
xfce-ja-64     xfce-en-64     xfce-ja-32      xfce-en-32      xfce-ja-pen4      xfce-en-pen4     \
xfce-pro-ja-64 xfce-pro-en-64                                                                    \
:
	@$(eval ARCHITECTURE=${shell echo ${@} | rev | cut -d '-' -f 1 | rev })
	@$(eval LOCALE=${shell echo ${@} | rev | cut -d '-' -f 2 | rev })
	@$(eval CHANNEL=${shell echo ${@} | sed "s/-${LOCALE}-${ARCHITECTURE}//g"})
	@[[ -z "${CHANNEL}" ]] && echo "Empty Channel" && exit 1 || :
	@case ${ARCHITECTURE} in\
		"pen4") sudo ${CURRENT_DIR}/${BUILD_SCRIPT} ${ARGS} ${SHARE_OPTION} ${ARCH_Pen4}   -l ${LOCALE} ${CHANNEL} ;;\
		"32"  ) sudo ${CURRENT_DIR}/${BUILD_SCRIPT} ${ARGS} ${SHARE_OPTION} ${ARCH_i686}   -l ${LOCALE} ${CHANNEL} ;;\
		"64"  ) sudo ${CURRENT_DIR}/${BUILD_SCRIPT} ${ARGS} ${SHARE_OPTION} ${ARCH_x86_64} -l ${LOCALE} ${CHANNEL};;\
		*     ) echo "Unknown Architecture"; exit 1  ;; \
	esac

menuconfig/build/mconf::
	@mkdir -p menuconfig/build
	(cd menuconfig/build ; cmake -GNinja .. ; ninja -j4 )

menuconfig:menuconfig/build/mconf menuconfig-script/kernel_choice menuconfig-script/channel_choice
	@menuconfig/build/mconf menuconfig-script/rootconf

menuconfig-script/kernel_choice:system/kernel-x86_64 system/kernel-i686 system/kernel-pen4
	@${CURRENT_DIR}/tools/kernel-choice-conf-gen.sh
menuconfig-script/channel_choice:
	@${CURRENT_DIR}/tools/channel-choice-conf-gen.sh

build_option:
	@if [ ! -f .config ]; then make menuconfig ; fi
	${CURRENT_DIR}/tools/menuconf-to-alterconf.sh ${CURRENT_DIR}/.build_option

clean:
	@sudo ${CURRENT_DIR}/${BUILD_SCRIPT} --noconfirm --debug clean

build:build_option
	$(eval BUILD_OPTION := $(shell cat ${CURRENT_DIR}/.build_option))
	@sudo ${CURRENT_DIR}/${BUILD_SCRIPT} ${BUILD_OPTION}

keyring::
	@sudo ${CURRENT_DIR}/tools/keyring.sh --alter-add --arch-add

wizard:
	@sudo ${CURRENT_DIR}/tools/wizard.sh

check:
	@bash -c 'shopt -s globstar nullglob; shellcheck -s bash --exclude=SC2068 -S error **/*.{sh,ksh,bash}'
	@bash -c 'shopt -s globstar nullglob; shellcheck -s bash --exclude=SC2068 -S error tools/*.{sh,ksh,bash}'


# デバッグ用
ARCH         := x86_64
CHANNEL      := xfce
LOCALE       := ja
custom:
	sudo ${CURRENT_DIR}/${BUILD_SCRIPT} ${ARGS} ${SHARE_OPTION} --arch ${ARCH} -l ${LOCALE} ${CHANNEL}
