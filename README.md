# stm32_devcontainer
VS Code development container for STM32 development. Contains STM32 Command Line Tools and STM32 CubeIDE Extensions installed for VS Code.

## Usage
1. Clone this repository to .devcontainer in your project folder
1. Download the desired CLT version from ST: https://www.st.com/en/development-tools/stm32cubeclt.html
1. Extract this download to get the *.sh file
1. Update the CLT_SCRIPT variable in the Dockerfile with the filename of the *.sh file.
1. Open your project in VS Code in a DevContainer
