# Installation on Windows
Most Windows versions require some special installation instructions.
Those instructions are described on this page.

For the normal instructions, a list of commands,
the FAQ and more visit the main [README](README.md).

## Requirements
* Operating system:
    * Windows 7, 8 or 10 Home/Mobile
    * For other operating systems versions,
      follow the [regular instructions](README.md#usage-on-other-windows-systems)
* [Docker Toolbox](https://www.docker.com/products/docker-toolbox)
  (not the normal Docker version)
* [Git](https://git-scm.com/)
* **Important:** VT-x / virtualization must be enabled in the BIOS.
  [More information](https://www.howtogeek.com/213795/how-to-enable-intel-vt-x-in-your-computers-bios-or-uefi-firmware/).
* ~1.3GB of free space

## Usage on Windows
Notice:
* If you're using Windows 10 Pro, Enterprise or Edu,
  do not use these instructions!
If you're running one of these three versions,
  you must follow the regular installation instructions [here](README.md#usage).
* Windows Vista, XP or earlier isn't supported.

#### Introduction
You're running Windows 7, 8 or Windows 10 Home/Mobile.
These versions of Windows don't nativly support Docker because the Windows
operating system is missing various features.
This project with the Docker container can still be installed however,
with a little workaround.
For these Windows versions, the project automatically set up a virtual machine
running Linux to run the Docker container in.
This might sound difficult,
but it's quite easy in fact as the process is fully automated!

**Warning:** Installing the project on these Windows versions will break
VirtualBox if installed. Virtual machines will still be available,
but you won't be able to start them anymore. There's no fix for this.

#### Installation
Follow these steps to get the container up and running:
* Make sure you meet all [requirements](#requirements) above,
  install required software.
* Clone the project repository
  (`git clone https://github.com/timvisee/hhs-p7-spark-docker.git`)
* Change into the project repository
  (`cd hhs-p7-spark-docker`)
* Install and start the container: `start.bat` or `update-and-start.bat`

The installation is started automatically when starting for the first time,
and will set up the virtual machine, container and user files.
The set up of the virtual machine and container might take a long while as it's
around 1.3GBs in size.

It's recommended to use the `update-and-start.bat` script in the future to
start the container. This will automatically fetch new updates when available.

#### Differences
Because the container is running in a virtual machine with this installation, 
some things might be a little different:
* The notebook directory isn't accessible from your Windows
  machine as described [here](README.md#data-directory). You don't have to manually
  access these files though, so you should be fine! If you'd like to access
  them anyway, some specific commands must be used.
* The performance of Jupyter Notebook might be slightly worse.

## More information
For more information, a list of commands,
the FAQ and more visit the main [README](README.md).
