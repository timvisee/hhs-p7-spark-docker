# HHS P7 Spark in Docker
A Docker image with a set of scripts to use and set up a container running
Apache Spark with PySpark, Jupyter Notebook and some other common tools.
With this project you can get a container up and running with a single command.

This container is intended for college, period 7 of HBO-ICT on the HHS,
and automatically installs various resources that are used in class.

## Features
* Single command to get everything up and running!
* Jupyter Notebook 4.3.x
* PySpark
* Python 3.5
* Spark 2.0.1
* Hadoop 2.7
* College resources preinstalled.

## Requirements
* Linux, Mac OS X or Windows 10 Professional/Enterprise
* [Docker](https://www.docker.com/)
* Docker composer (should come with Docker)
* [Git](https://git-scm.com/)
* ~1.3GB of free space

## Usage
Follow these steps to get the container up and running.
* Clone the project repository (`git clone https://github.com/timvisee/hhs-p7-spark-docker.git`)
* Change into the project repository (`cd hhs-p7-webshop-project`)
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

## License
This project is released under the GNU GPL-3.0 license.
Check out the [LICENSE](LICENSE) file for more information.
