# stm32_devcontainer
VS Code development container for STM32 development. Contains STM32 Command Line Tools and STM32 CubeIDE Extensions installed for VS Code.

## Usage
1. Clone this repository to .devcontainer in your project folder
1. Copy 49-stlink.rules to /etc/udev/rules.d to get ST-Link USB devices tagged with the correct group
1. Open your project in VS Code in a DevContainer
1. When the container opens, it will ask if you want to install the STM32 bundle extensions. Select yes.
1. When these are done installing, you are ready to start

## Creating a New STM32 Project
1. On your host, run CubeMX to create a new project for your board/device.
1. Use CubeMX to configure your project as desired.
1. Generate code from CubeMX, selecting CMake as the Toolchain / IDE. This will generate code inside your project folder (assuming your *.ioc file is at the same level as your .devcontainer directory).
1. Inside your devcontainer, you will see the newly generated code.
1. Run the command "CMake: Configure" to configure the project.
1. Click build on the bottom status bar in VSCode to build the new project.

## Debugging
1. You can use the launch.json provided as an example to set up a debug command.
1. Place this launch.json inside the .vscode directory in your project folder.
1. Edit your new launch.json to edit the device field to match the device for your project.
1. On your Side Bar, select Run and Debug, then click the Play button. This will build and start debugging your application on your target.


## Windows Usage
For use on Windows, you will need Docker Desktop and WSL2 installed.
Building code will work without any additional changes on Windows. However, to get debugging to work, you also will need USBIP-win (get the latest release [here](https://github.com/dorssel/usbipd-win/releases/).

Once you have WSL2 installed, run the following commands to setup a udev rule for ST-Link devices. This will ensure they have the proper permissions to pass through to the Docker container.
```
sudo bash -c 'echo "SUBSYSTEM==\"usb\", ATTR{idVendor}==\"0483\", MODE=\"0666\"" > /etc/udev/rules.d/50-stlink.rules'
sudo udevadm control --reload-rules
sudo udevadm trigger
```

Then, to attach the debugger to your container, first attach the device to your machine and run the following commands:
```
# In an admin PowerShell
usbipd list  # Make note of the BUSID value of the ST-Link Debug device listed
usbipd bind --busid <busid>
usbipd attach --wsl --busid <busid>

# Inside the devcontainer
lsusb
```
