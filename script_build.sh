#!/bin/bash

# Clone this script in your ROM Repo using following commands.
# cd rom_repo
# curl https://raw.githubusercontent.com/LegacyServer/Scripts/master/script_build.sh > script_build.sh

# Some User's Details. Please fill it by your own details.
# Replace "legacy" with your own SSH Username in lowercase
username=legacy

# colors
export TERM=xterm

    red=$(tput setaf 1)             #  red
    grn=$(tput setaf 2)             #  green
    blu=$(tput setaf 4)             #  blue
    cya=$(tput setaf 6)             #  cyan
    txtrst=$(tput sgr0)             #  Reset
# ccache

if [ "$use_ccache" = "yes" ];
then
echo -e ${blu}"CCACHE is enabled for this build"${txtrst}
export USE_CCACHE=1
export CCACHE_DIR=/home/ccache/$username
prebuilts/misc/linux-x86/ccache/ccache -M 50G
fi

if [ "$use_ccache" = "clean" ];
then
export CCACHE_DIR=/home/ccache/$username
ccache -C
wait
echo -e ${grn}"CCACHE Cleared"${txtrst};
fi

# clean
if [ "$make_clean" = "yes" ];
then
make clean && make clobber
wait
echo -e ${cya}"OUT dir from your repo deleted"${txtrst};
fi


# build
. build/envsetup.sh
lunch lineage_$device-userdebug
make $target_command -j8
