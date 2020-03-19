::Windows path to fslview_wrapper.sh
set WRAPPER_FUNC=%1
::Convert path '\'s to '\\'s, so that Ubuntu doesn't treat them as escape characters
set "WRAPPER_FUNC_WSL=%WRAPPER_FUNC:\=\\%"
::Convert Windows path to WSL path
for /f %%i in ('wsl.exe wslpath %WRAPPER_FUNC_WSL%') do set WRAPPER_FUNC_WSL=%%i
::Use an environment variable to pass the path to the WSL
set WSLENV=WRAPPER_FUNC_WSL/u

::Optional NIfTI to open with FSLeyes
set NIFTI_PATH=%2
if [%NIFTI_PATH%]==[] (
    START wsl bash -c "$WRAPPER_FUNC_WSL"
    GOTO :EOF
) else ( 
    ::Convert Windows path '\'s to '\\'s, so that Ubuntu doesn't treat them as escape characters
    set "NIFTI_PATH_NEW=%NIFTI_PATH:\=\\%"
)
::Use an environment variable to pass the NifTI filepath to the WSL
set WSLENV=WRAPPER_FUNC_WSL:NIFTI_PATH_NEW/u
START wsl bash -c "$WRAPPER_FUNC_WSL $NIFTI_PATH_NEW"
GOTO :EOF