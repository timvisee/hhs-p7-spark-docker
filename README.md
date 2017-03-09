[![Build Status on Travis CI on master](https://travis-ci.org/timvisee/hhs-p7-spark-docker.svg?branch=master)](#automated-builds)
[![Docker Hub pulls](https://img.shields.io/docker/pulls/timvisee/hhs-p7-spark-docker.svg)](https://hub.docker.com/r/timvisee/hhs-p7-spark-docker/)
[![Docker Hub stars](https://img.shields.io/docker/stars/timvisee/hhs-p7-spark-docker.svg)](https://hub.docker.com/r/timvisee/hhs-p7-spark-docker/)

# HHS P7 Spark in Docker
This project allows you to get PySpark with Jupyter Notebook up and running
with a single command!

Check out the [usage](#usage) section for installation instructions.

This project uses a container based solution using Docker. It sets up an
isolated 'container' that has all required software pre-installed. This
is comparable to a virtual machine, but it's much more flexible and has
near-native performance. All this is done automatically, with nothing to
worry about.

This project provides a custom Docker image with a set of scripts to use and
set up a container running Apache Spark with PySpark, Jupyter Notebook and some
other common tools.

This container is intended for college, period 7 of HBO-ICT on the HHS,
and has various resources and assignments used in class preinstalled!

## Features
* Single command to get everything up and running!
* Jupyter Notebook 4.3.0
* PySpark 2.0.1
* Python 3.5.1
* Spark 2.0.1
* Hadoop 2.7
* College resources preinstalled.

## Requirements
* Operating system:
    * Linux
    * Mac OS X
    * Windows 10 Pro, Enterprise or Edu
    * For other Windows versions, follow the [special instructions](#usage-on-other-windows-systems)
* [Docker](https://www.docker.com/)
* Docker composer (should come with Docker or Docker Toolbox)
* [Git](https://git-scm.com/)
* **Important:** VT-x / virtualization must be enabled in the BIOS.
  [More information](https://www.howtogeek.com/213795/how-to-enable-intel-vt-x-in-your-computers-bios-or-uefi-firmware/).
* ~1.3GB of free space

## Usage
Follow these steps to get the container up and running:
* Make sure you meet all [requirements](#requirements) above,
  install missing software.
* Clone the project repository
  (`git clone https://github.com/timvisee/hhs-p7-spark-docker.git`)
* Change into the project repository
  (`cd hhs-p7-spark-docker`)
* **Important:** If on Windows, enable sharing of the drive the project is
  installed on.
  [More information](https://blogs.msdn.microsoft.com/stevelasker/2016/06/14/configuring-docker-for-windows-volumes/).
* Install and start the container:
    * Linux/OSX: `./start` or `./update-and-start`
    * Windows: `start.bat` or `update-and-start.bat`

It's recommended to use the `./update-and-start` / `update-and-start.bat`
script in the future to start the container. This will automatically fetch
new updates when available.

The installation is started automatically when starting for the first time.
The download of the container image might take a long while as it's around
1.3GBs in size.

## Usage on other Windows systems
* If you're using Windows 10 Pro, Enterprise or Edu, do not use these instructions!
If you're running one of these three versions, you must follow the regular installation instructions [here](#usage).
* Windows Vista, XP or earlier isn't supported.

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

Follow these steps to get the container up and running:
* Install [Docker Toolbox](https://www.docker.com/products/docker-toolbox) (not the normal Docker version)
* Make sure you meet all [requirements](#requirements) above.
  Do not install the normal Docker version, as we're using Docker Toolbox for this installation!
  Install other required software.
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

Because the container is running in a virtual machine with this installation, 
some things might be a little different:
* The notebook directory isn't accessible from your Windows
  machine as described [here](#data-directory). You don't have to manually
  access these files though, so you should be fine! If you'd like to access
  them anyway, some specific commands must be used.
* The performance of Jupyter Notebook might be slightly worse.

## Scripts and commands
The following scripts/commands are included in the project:
* `./start` / `start.bat`:
  Start the container (invokes install if required)
* `./update-and-start` / `update-and-start.bat`:
  Update and start the contanier (invokes install if required)
* `./stop` / `stop.bat`:
  Stop running containers
* `./install` / `install.bat`:
  Install the container
* `./update` / `update.bat`:
  Update the container and all scripts
* `./uninstall` / `uninstall.bat`:
  Uninstall the container and it's resources

To reopen Jupyter Notebook in the browser for a running container,
simply execute the `./start` / `start.bat` script again.

## Builds
### Automated builds
For each commit, a build and test is automatically started using a CI service.
Successful builds are automatically deployed, and will be used by everybody
using this project with these management scripts.

|Service|Branch|Build Status| |
|---:|:---|:---:|:---|---|
|Travis CI|master|[![Build status on Travis CI on master](https://travis-ci.org/timvisee/hhs-p7-spark-docker.svg?branch=master)](https://travis-ci.org/timvisee/hhs-p7-spark-docker)|[View Status](https://travis-ci.org/timvisee/hhs-p7-spark-docker)|
|Travis CI|last commit|[![Build status on Travis CI for last commit](https://travis-ci.org/timvisee/hhs-p7-spark-docker.svg)](https://travis-ci.org/timvisee/hhs-p7-spark-docker)|[View Status](https://travis-ci.org/timvisee/hhs-p7-spark-docker)|

### Build it yourself
First of all, it's not required to build anything yourself. Simply use the
[start](#usage) script to get things up and running.
Sometimes however, this is useful if you've manually made changes to the docker
image configuration, or when you want to debug things.

If you're using a Linux or Mac OS X operating system, it's possible to build
the container image yourself.
Simply use the `image/build` script to start a build!

If you've permission to push updates to the main hosted image that everybody
uses, you can also use the following scripts:
Use the `image/push` or `image/build-and-push` scripts to build and push an
update.

## Data directory
The notebook directory is accessable at `./notebook` in the project repository
when the container is run.

On Windows it is required to enable drive sharing in the Docker settings on the
drive the repository and container is installed on. The notebook directory
should be in the same location, but it might differ depending on the
configuration.

## FAQ
#### The container doesn't start, what to do?
This is probably because you haven't enabled VT-x / virtualization in your BIOS.
Enable this and try it again.
See the [requirements](#requirements) for more information.

#### How do I open Jupyter Notebook in my browser?
Jupyter Notebook should automatically open in your browser when you start the
container.
If the container is already running, simply run `./start` / `start.bat` again
to re-open Jupyer Notebook.

#### How do I get updates?
New updates will automatically be installed if available when running the
`./update` / `update.bat` script. It's recommended to use the
`./update-and-start` / `update-and-start.bat` scripts to start the container
in the future, as this automatically installs any available updates when
avaialable before the container is starting.

#### Do I need to enable VT-x / virtualization?
Yes, virtualization must be enabled to use this container.
The Docker installer should notify about this.
Search on Google for how to enable virtualization on your specific system.

#### Can I access the files in Jupyter Notebook?
Yes, these files are available in a sub directory.
See the [data directory](#data-directory) section.

#### Can I safely stop the container?
Yes. All data will remain intact.
The container can be stopped using the `./stop` / `stop.bat` command.

#### Does this work on Windows?
Yes. Even though the container is based on
[Alpine Linux](https://alpinelinux.org/), Docker ensures that it will run on
Windows too.

## License
This project is released under the GNU GPL-3.0 license.
Check out the [LICENSE](LICENSE) file for more information.
