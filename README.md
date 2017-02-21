# HHS P7 Spark in Docker
A set of scripts to use and set up a Docker container running Apache Spark
along with some other common tools. This project allows you to get a
container up and running with a single command.

This container is intended for college, period 7 of HBO-ICT on the HHS,
and automatically installs various resources that are used in class.

The base Docker image that is used for this container can be found [here](https://github.com/jupyter/docker-stacks/tree/master/all-spark-notebook).

## Features
* Single command to get everything up and running!
* Jupyter Notebook 4.3.x
* PySpark
* Python 3.x and Python 2.7.x
* Spark 2.0.2
* Hadoop 2.7
* [Various other tools](https://github.com/jupyter/docker-stacks/tree/master/all-spark-notebook#what-it-gives-you)

## Requirements
* Linux, Mac OS X or Windows 10 operating system
* [Docker](https://www.docker.com/)
* Docker composer (should come with Docker)
* [Git](https://git-scm.com/)
* ~6GB of free space

## Usage
Follow these steps to get the container up and running.
* Clone the project repository (`git clone https://github.com/timvisee/hhs-p7-spark-docker.git`)
* Change into the project repository (`cd hhs-p7-webshop-project`)
* Install and start the container:
    * Linux/OSX: `./start`
    * Windows: `start.bat`

The installation is started automatically when starting for the first time.
The download of the container image might take a long while as it's around
6GBs in size.

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
simply execute the `./start`/`start.bat` command again.

## Data directory
On Linux and Mac OS X the working directory is available at `./work`.

On Windows the working directory is mounted to a drive letter.
This letter differs per installation, and can be configured in the Docker 
settings panel.

## License
This project is released under the GNU GPL-3.0 license.
Check out the [LICENSE](LICENSE) file for more information.
