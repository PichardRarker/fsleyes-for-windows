# fsleyes-for-windows
Scripts and instructions for creating a simple .exe wrapper for FSLeyes, allowing it to be launched from the Windows GUI. An equivalent is also provided for (the now deprecated) FSLview.

![](https://github.com/PichardRarker/fsleyes-for-windows/blob/master/fsleyes-for-windows.png) 

 ## Usage
 After setup, double-clicking the fsleyes shortcut will open the program. It's also possible to set `fsleyes.exe` as the default program for opening `.nii` or `nii.gz` files,  using the `'Open with'` option after right-clicking on a suitable file (works when opening files from remote locations, also).<br>
<br>
 :warning:```You must have an X server running for the program to work! See the setup instructions.```


## Requirements
   1. Windows 10
   2. [Windows Subsystem for Linux (WSL)](https://docs.microsoft.com/en-us/windows/wsl/install-win10)
   3. A Windows [X client](https://superuser.com/questions/99303/what-are-my-x-client-options-for-ms-windows)
   4. A recent build of [FSL](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki) (.exe developed on FSL 6.0.3)
   
## Setup instructions
   1. After downloading the WSL Linux distribution of your choice, follow the [official FSL install instructions for Windows WSL ](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FslInstallation/Windows). If you've done this previously, then a re-install shouldn't be neccessary. If you've already downloaded an X client for your windows machine, then you can skip this step in the FSL instructions: `2. Install XMING (in Windows)`
   2. As per the [FSL shell setup instructions](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FslInstallation/ShellSetup), add the following to your WSL ~/.bashrc file:
      ```
      FSLDIR=/usr/local/fsl
      . ${FSLDIR}/etc/fslconf/fsl.sh
      PATH=${FSLDIR}/bin:${PATH}
      export FSLDIR PATH
      ```
      **(if you've used a non-standard install dir, then the FSLDIR variable will need to be changed accordingly)**
   3. Clone the `fsleyes-for-windows` repo, and extract the contents to a Windows folder of your choosing. 
   4. Using `cmd.exe` or `powershell.exe`, navigate to the extracted directory. In Powershell, you can use something like this:
      ```
      cd C:\Users\rparker\Documents\fsleyes-for-windows\
      ```
   5. [Track down a C# compiler on your particular build of Windows 10](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/compiler-options/command-line-building-with-csc-exe), and use it to build the .exe:
      ```
      C:\Windows\Microsoft.NET\Framework\v4.0.30319\csc.exe /target:winexe fsleyes.cs /win32icon:fsleyes.ico
      ```
   6. You should now see `fsleyes.exe` in the setup directory. You'll probably want to create a shortcut to this file in a more convenient location.  
    :warning:```Don't move the actual .exe file! This will break things.```
   7. Prior to launching `fsleyes.exe`, make sure your X client of choice is up and running. This code was tested using the X server tools integrated into [MobaXterm](https://mobaxterm.mobatek.net/), but any reputable Windows X client should do the job. 
   8. View things! `fsleyes.exe` will be a bit slow to launch the first time, but should be a bit quicker on subsequent executions.
   9. FSLeyes is a fantastic tool, but can sometimes be a bit slow to launch. In my experience, FSLview opens a lot quicker, and its `Movie Mode` function is much faster than the FSLeyes equivalent (important when assessing motion within fMRI or dMRI sequences, for example). If you also want to create an `fslview.exe`, follow steps 4-6, but use `'fslview'` instead of `'fsleyes'` when compiling. Assuming the same path structure as in step 4, `fslview.exe` setup tools can be found here:
    ```
    C:\Users\rparker\Documents\fsleyes-for-windows\fslview
    ```
   
   ## Debugging
   
   Both `fsleyes.exe` and `fslview.exe` create a small logfile in their respective install directories (and these same files are over-written with each execution). If the applications fail to open, these files should point to the issue. If no logfiles are generated, then this means `fsleyes_wrapper.sh`/`fslview_wrapper.sh` has not been called, and points to an issue with the WSL setup.<br>
   <br>
   Any problems, then please let me know!
   
   ## Resources 
   
   fsleyes.ico and fslview.ico files generated using images stolen (with the utmost respect) from official FSL sources. 
   

