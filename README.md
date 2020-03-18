# fsleyes-for-windows
A simple .exe wrapper for FSLeyes, allowing it to be started from the Windows GUI


## Prerequisites
   1. Windows 10
   2. [Windows Subsystem for Linux (WSL)](https://docs.microsoft.com/en-us/windows/wsl/install-win10)
   3. A [Windows X client](https://superuser.com/questions/99303/what-are-my-x-client-options-for-ms-windows)
   
## Install instructions
   1. After downloading the WSL Linux distribution of your choice, follow the [official FSL install instructions for Windows WSL ](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FslInstallation/Windows). If you've done this previously, then a re-install shouldn't be neccessary. If you've already downloaded an X client for your windows machine, then you can skip this step in the FSL instructions: `2. Install XMING (in Windows)`
   2. As per the [official FSL shell setup instructions](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FslInstallation/ShellSetup), add the following to your WSL ~/.bashrc file:
      ```
      FSLDIR=/usr/local/fsl
      . ${FSLDIR}/etc/fslconf/fsl.sh
      PATH=${FSLDIR}/bin:${PATH}
      export FSLDIR PATH
      ```
      **(if you've used a non-standard install dir, then the FSLDIR variable will need to be changed accordingly)**
   3. Clone the `fsleyes-for-windows` repo, and extract the contents to a Windows folder of your choosing. 
   4. Copy the extracted file `fsleyes_wrapper.sh` to a WSL path. 
