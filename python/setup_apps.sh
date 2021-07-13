#!/bin/bash

# Copyright (c) 2021, Mikko Niemelä a.k.a. Lord Mike (lordmike@iki.fi)
# 
# License of this script file:
#   MIT License
# 
# License is available online:
#   https://github.com/lordmikefin/LMAutoSetBotUbM/blob/master/LICENSE
# 
# Latest version of this script file:
#   https://github.com/lordmikefin/LMAutoSetBotUbM/blob/master/python/setup_apps.sh


# setup_apps.bat
# This script will start python script.
# 
# The python script will download and install apps.



unset CURRENT_SCRIPT_VER CURRENT_SCRIPT_DATE
CURRENT_SCRIPT_VER="0.0.1"
CURRENT_SCRIPT_DATE="2021-07-13"
echo "CURRENT_SCRIPT_VER: ${CURRENT_SCRIPT_VER} (${CURRENT_SCRIPT_DATE})"




CURRENT_SCRIPT_REALPATH=$(realpath ${BASH_SOURCE[0]})
CURRENT_SCRIPT_DIR=$(dirname ${CURRENT_SCRIPT_REALPATH})
CURRENT_SCRIPT=$(basename ${CURRENT_SCRIPT_REALPATH})
LM_TOYS_DIR=$(realpath "${CURRENT_SCRIPT_DIR}/../submodule/LMToysBash")
#IMPORT_FUNCTIONS="$(realpath "${CURRENT_SCRIPT_DIR}/../../script/lm_functions.sh")"
IMPORT_FUNCTIONS=$(realpath "${LM_TOYS_DIR}/lm_functions.sh")
if [[ ! -f "${IMPORT_FUNCTIONS}" ]]; then
	>&2 echo "${BASH_SOURCE[0]}: line ${LINENO}: Source script '${IMPORT_FUNCTIONS}' missing!"
	exit 1
fi

source ${IMPORT_FUNCTIONS}

if [ ${LM_FUNCTIONS_LOADED} == false ]; then
	>&2 echo "${BASH_SOURCE[0]}: line ${LINENO}: Something went wrong while loading functions."
	exit 1
elif [ ${LM_FUNCTIONS_VER} != "1.3.4" ]; then
	lm_functions_incorrect_version
	if [ "${INPUT}" == "FAILED" ]; then
		lm_failure
	fi
fi






# NOTE to myself: Read more about executeing commands from filename in Bash.
#   ( https://superuser.com/questions/46139/what-does-source-do )

# NOTE to myself: Read more about Bash conditional statements.
#   ( http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html )

# NOTE to myself: Read more about how to get distribuiton info.
#   ( https://unix.stackexchange.com/questions/6345/how-can-i-get-distribution-name-and-version-number-in-a-simple-shell-script )

unset DISTRO_INFO IS_UBUNTU EXEC_MATE_ABOUT IS_MATE
DISTRO_INFO="/etc/os-release"
if [[ -r "${DISTRO_INFO}" ]] ; then
	source "${DISTRO_INFO}" # Executeing commands from file. Import variables.
else
	echo -e "\n '${DISTRO_INFO}' file missing or is not readable.  Aborting." >&2
	exit 1
fi
#echo -e "\n Distro name: ${NAME}, Version: ${VERSION}"

#if [[ ${NAME} != "Ubuntu" ]] ; then
#	echo -e "\n This script is tested only with Ubuntu.  Aborting." >&2
#	exit 1
#fi

case ${NAME} in
	Ubuntu )
		echo "Distro is Ubuntu" 
		IS_UBUNTU=1 ;;
	* )
		echo -e "\n This script is tested only with Ubuntu.  Aborting." >&2
		exit 1
		;;
esac

if [[ ${IS_UBUNTU} -eq 1 ]] ; then
	#which mate-about >/dev/null && { echo "Is MATE"; echo "$(mate-about -v)"; }
	EXEC_MATE_ABOUT="$(which mate-about)"
	#echo "EXEC_MATE_ABOUT: '${EXEC_MATE_ABOUT}'"
	if [[ -n ${EXEC_MATE_ABOUT} ]] ; then
		IS_MATE=1
		echo "$(${EXEC_MATE_ABOUT} -v)"
	else
		echo -e "\n 'mate-about' is not installed."
		echo -e "\n This script is tested only with MATE.  Aborting." >&2
		exit 1
	fi
else
	echo -e "\n This script is tested only with UBUNTU.  Aborting." >&2
	exit 1
fi




#echo -e "\n This script is in test mode :)  Aborting." >&2
#exit 1


echo ""
APP_PY="python3"
PY_VERSION=$(lm_get_app_version ${APP_PY})  || lm_failure
#echo ${PY_VERSION}
if [ -z "${PY_VERSION}" ] ; then
	echo "'${APP_PY}' is not installed !"
	echo -e "\n Run init.sh first.  Aborting." >&2
else
	echo "'${APP_PY}' is installed."
fi




# the venv
VENV="venv-LMAutoSetBotUbM"
VENV_PATH="${HOME}/Venv"




# I will try to use virtual environment 'venv-LMAutoSetBotUbM'.
echo ""
echo "I will try to use virtual environment '${VENV}'."
echo "All my python scripts will use this environment."
echo " $ source ${VENV_PATH}/${VENV}/bin/activate"
source ${VENV_PATH}/${VENV}/bin/activate  && {
	echo ""
	echo "Now workon  ${VENV}"
	echo ""
} || {
	echo ""
	echo "Virtual environment '${VENV}' not found."
	echo ""
	echo -e "\n Run setup_python_venv.sh first.  Aborting." >&2
	exit 1
}



echo ""
echo "Current virtual environment:"
echo "  ${VIRTUAL_ENV}"
echo ""


echo ""
echo "Current variable PATH:"
echo "  ${PATH}"
echo ""



echo "   TODO: run setup_apps.py"


echo ""
echo "Current variable PATH:"
echo "  ${PATH}"
echo ""


echo "End of script '${CURRENT_SCRIPT}'"


