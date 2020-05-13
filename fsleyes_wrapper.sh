#!/bin/bash -i

function script_help {
  echo '##################################################################################################'
  echo 'File:                   fsleyes_wrapper.sh'
  echo ""
  echo 'Description:            Simple wrapper for FSLeyes, designed to be used in WSL. Script initialises'
  echo '                        FSL, sets up some logfiles, then launches FSLeyes'
  echo ""
  echo 'Author(s):              Richard Parker'
  echo ""
  echo 'Version:                1.0 (19 March 2020)'
  echo ""
  echo ""
  echo 'Parameters:             [Optional]'
  echo ''
  echo '                        -h         Script help'
  echo "                        "'$1'"         Windows path to a NIfTI volume (using '\\\\' instead of '\')"
  echo ""
  echo '#####################################################################################################'
  exit 1
}

function fatal () {
	#Error reporting
  echo -e "\n[ERROR $SCRIPTNAME] - ${1} - $(date)\n"
	echo "[ERROR $SCRIPTNAME] - ${1} - $(date)" >> "$LOGFILE"
	exit 1
}

#Simple helper function 
if [ "$#" -ne 0 ] &&
   ([ $1 == "-h" ] || [ $1 == "--h" ] || [ $1 == "-help" ] || [ $1 == "--help" ]); then 
    script_help
fi 

#Create a logfile in the script dir
ROOTDIR="$( cd "$(dirname "$0")" ; pwd -P )"
export SCRIPTNAME=$( basename $0 )
export LOGFILE=$ROOTDIR/fsleyes_wrapper.log 
[ -f $LOGFILE ] && rm $LOGFILE


#Initialise FSL (IMPORTANT: FSL config info must be present in 
#~/.bashrc, as per https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FslInstallation/ShellSetup

#Trick Ubuntu into thinking the session is interactive
#(so that .bashrc can be sourced properly)
export PS1=123
. ~/.bashrc
[ -z ${FSLDIR+x} ] && fatal "FSLDIR not found within ~/.bashrc. Is FSL installed properly?"
echo FSLDIR is $FSLDIR >> $LOGFILE

#Convert Windows path to Ubuntu one
if [ "$#" -ne 0 ]; then 
    NII_PATH_WINDOWS=$1
    NII_PATH_WSL=$( wslpath -a $NII_PATH_WINDOWS ) >> $LOGFILE 2>&1
    echo "Converted Windows filepath $NII_PATH_WINDOWS to WSL path $NII_PATH_WSL" >> $LOGFILE
else
    NII_PATH_WSL=""
        echo "No additional filepath provided. FSLeyes will open without a loaded image" >> $LOGFILE
fi 

#Launch FSLeyes!
$FSLDIR/bin/fsleyes $NII_PATH_WSL >> $LOGFILE 2>&1

