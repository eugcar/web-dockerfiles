# web-dockerfiles - PHP
This file describes the PHP image.

### What is provided?
This image provides:

* CentOS 7.7
* PHP 7.4
* Composer
* NodeJS
* Yarn

### How this works?
For this to work properly the following requirements should be fulfilled:

* The HOST_USER_ID environment variable containing the host machine user ID should exist.
* The HOST_GROUP_ID environment variable containing the host machine group ID should exist.

#### Custom configuration 
This image offers the possibility to use custom configuration files.
Currently handled files are:

* `php.ini`.
* PHP extensions configuration files.

For this to work you have to mount at path `/docker-entrypoint-init.d` a folder 
containing custom configuration files. At the root of the mounted folder:

* The `php` folder containing:
    * `php.ini`.
    * The `php.d` folder containing PHP extension configuration files.

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

#### Custom PHP extensions
This image offers the possibility to install additional PHP extensions.
 
For this to work you have to mount at path `/docker-entrypoint-init.d` a folder 
containing the extensions file. At the root of the mounted folder:
 
* The `php_extensions` file should be placed.
 
The file should contain one row for each extension. This is an example of a `php_extensions` file:

```
php74-php-common
php74-php-json
php74-php-pdo
php74-php-pecl-imagick
```
 
The PHP extensions will be installed within the container at the first execution.

#### Custom parameters.yml file
This image offers the possibility to create a custom `parameters.yml` file if not present.

For this to work you have to define:
* The ENCODED_PARAMETERS_FILE environment variable containing the base64 encoded version of the `parameters.yml` file.

If the file is already present at path `/var/www/html/app/config/parameters.yml` then the env variable will be ignored. 
Otherwise the content of the provided variable will be decoded base64 and the file will be created.
