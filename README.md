# HHS P7 Spark in Docker
This project allows you to get PySpark with Jupyter Notebook up and running
with a single command!

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

Check out the [usage](#usage) section for installation instructions.

## Features
* Single command to get everything up and running!
* Jupyter Notebook 4.3.0
* PySpark 2.0.1
* Python 3.5.1
* Spark 2.0.1
* Hadoop 2.7
* Based on Alpine Linux.
* College resources preinstalled.

## Requirements
* Operating system:
    * Linux
    * Mac OS X _(not yet tested, should work)_
    * Windows 10 Professional or Enterprise
* [Docker](https://www.docker.com/)
* Docker composer (should come with Docker)
* [Git](https://git-scm.com/)
* VT-x / virtualization must be enabled.
* ~1.3GB of free space

## Usage
Follow these steps to get the container up and running.
* Make sure you meet all [requirements](#requirements) above,
  install missing software.
* Clone the project repository
  (`git clone https://github.com/timvisee/hhs-p7-spark-docker.git`)
* Change into the project repository
  (`cd hhs-p7-spark-docker`)
* If on Windows, enable sharing of your primary drive in the Docker settings.
* Install and start the container:
    * Linux/OSX: `./start`
    * Windows: `start.bat`

The installation is started automatically when starting for the first time.
The download of the container image might take a long while as it's around
1.3GBs in size.

## Commands
The following commands/scripts are included in the project:
* Start the container:
    * Linux/OSX: `./start`
    * Windows: `start.bat`
* Stop running containers:
    * Linux/OSX: `./stop`
    * Windows: `stop.bat`
* Install the container:
    * Linux/OSX: `./install`
    * Windows: `install.bat`
* Update the container and it's scripts:
    * Linux/OSX: `./update`
    * Windows: `update.bat`

To reopen Jupyter Notebook in the browser for a running container,
simply execute the `./start` / `start.bat` command again.

## Data directory
The notebook directory is accessable at `./notebook` in the project repository
when the container is run.

On Windows it is required to enable drive sharing in the Docker settings on the
drive the repository and container is installed on. The notebook directory
should be in the same location, but it might differ depending on the
configuration.

## FAQ
#### How do I open Jupyter Notebook in my browser?
Jupyter Notebook should automatically open in your browser when you start the
container.
If the container is already running, simply run `./start` / `start.bat` again
to re-open Jupyer Notebook.

#### Do I need to enable VT-x / Virtualization?
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
Yes. Even though the container is using a Linux image, Docker ensures that it
will run on Windows too.

## License
This project is released under the GNU GPL-3.0 license.
Check out the [LICENSE](LICENSE) file for more information.
