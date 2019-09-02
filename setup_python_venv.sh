#!/bin/bash

# Copyright (c) 2019, Mikko Niemelä a.k.a. Lord Mike (lordmike@iki.fi)
# 
# License of this script file:
#   MIT License
# 
# License is available online:
#   https://github.com/lordmikefin/LMAutoSetBotWin/blob/master/LICENSE.rst
# 
# Latest version of this script file:
#   https://github.com/lordmikefin/LMAutoSetBotWin/blob/master/setup_python_venv.sh


# setup_python_venv.sh
# This script will setup Python virtual environment for my scripts :)



unset CURRENT_SCRIPT_VER CURRENT_SCRIPT_DATE
CURRENT_SCRIPT_VER="0.0.1"
CURRENT_SCRIPT_DATE="2019-09-02"
echo "CURRENT_SCRIPT_VER: ${CURRENT_SCRIPT_VER} (${CURRENT_SCRIPT_DATE})"




CURRENT_SCRIPT_REALPATH=$(realpath ${BASH_SOURCE[0]})
CURRENT_SCRIPT_DIR=$(dirname ${CURRENT_SCRIPT_REALPATH})
CURRENT_SCRIPT=$(basename ${CURRENT_SCRIPT_REALPATH})
LM_TOYS_DIR=$(realpath "${CURRENT_SCRIPT_DIR}/submodule/LMToysBash")
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
elif [ ${LM_FUNCTIONS_VER} != "1.2.2" ]; then
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


echo ""
APP_PIP="pip3"
PIP_VERSION=$(lm_get_app_version ${APP_PIP})  || lm_failure
if [ -z "${PIP_VERSION}" ] ; then
	echo "'${APP_PIP}' is not installed !"
	echo -e "\n Run init.sh first.  Aborting." >&2
else
	echo "'${APP_PIP}' is installed."
fi


# Make sure we are using the lates pip version.
echo ""
echo "Make sure we are using the lates pip version."
#echo " $ ${APP_PIP} install --upgrade pip"
#${APP_PIP} install --upgrade pip
echo ""
echo "NOTE: Newer update 'pip' with 'pip' !!!  It will break something ?!?!?!"
echo "      Always use 'sudo apt-get install python3-pip'"
# TODO: Is there way to update pip without breaking Ubuntu package manager?


# Installing root environment (Python) modules.
echo ""
echo "Installing root environment (Python) modules."
echo ""
echo " $ ${APP_PIP} install -U -r root_environment_requirements_linux.txt"
${APP_PIP} install -U -r root_environment_requirements_linux.txt  || lm_failure


# List of 'Root' environment modules
echo ""
echo "List of 'Root' environment modules"
# NOTE: Ubuntu is using extreme old 'pip' which does not have parameter 'format' :(
#echo " $ ${APP_PIP} list --format=columns"
#${APP_PIP} list --format=columns
echo " $ ${APP_PIP} list"
${APP_PIP} list



# Create the venv
VENV="venv-LMAutoSetBotUbM"
VENV_PATH="${HOME}/Venv"
func_create_venv () {
	echo "I will create a new virtual environment '${VENV}'"
	echo " $ virtualenv -p /usr/bin/python3 ${VENV_PATH}/${VENV}"
	echo ""
}

# I will try to use virtual environment 'venv-LMAutoSetBotUbM'.
echo ""
echo "I will try to use virtual environment '${VENV}'."
echo "All my python scripts will use this environment."
echo " $ source ${VENV_PATH}/${VENV}/bin/activate"
#::call %USERPROFILE%\Envs\venv-LMAutoSetBotWin\Scripts\activate.bat
#call workon venv-LMAutoSetBotWin
source ${VENV_PATH}/${VENV}/bin/activate  && {
	echo ""
	echo "Virtual environment '${VENV}' already exists."
	echo "Now workon  ${VENV}"
	echo ""
} || {
	echo ""
	echo "Virtual environment '${VENV}' not found."
	echo "Next I will create the venv."
	echo ""
	lm_pause
	func_create_venv
}


#ls ${VENV_PATH}  || {
#	mkdir ${VENV_PATH}  
#}


echo "End of script '${CURRENT_SCRIPT}'"


