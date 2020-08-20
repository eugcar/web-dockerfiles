# web-dockerfiles - Apache
This file describes the Apache image.

### What is provided?
This image provides:

* CentOS 7.6
* Apache 2.4

### How this works?
For this to work properly the following requirements should be fulfilled:

* The HOST_USER_ID environment variable containing the host machine user ID should exists.
* The HOST_GROUP_ID environment variable containing the host machine group ID should exists.

#### Custom configuration 
This image offers the possibility to use custom configuration files.
Currently handled files are:

* `httpd.conf`.
* vhost files.
* modules configuration files.

For this to work you have to mount at path `/docker-entrypoint-init.d` a folder 
containing custom configuration files. At the root of the mounted folder:

* The `httpd.conf` file should be placed.
* The `conf.d` folder containing vhost files should be placed.
* The `conf.modules.d` folder containing modules configuration files should be placed.

The files provided will be copied at their right paths within the container 
at the first execution.

#### Custom scripts 
This image offers the possibility to run custom shell scripts.
Currently handled files are:

* *.sh files.

**Note**: The script files must be executable.

For this to work you have to mount at path `/docker-entrypoint-init.d` a folder 
containing custom scripts. At the root of the mounted folder:

* The `scripts` folder containing script files should be placed.

The scripts provided will be executed, as root user, within the container at the first execution.