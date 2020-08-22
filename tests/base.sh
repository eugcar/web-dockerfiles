#!/usr/bin/env bash

# Paths to assert functions
readonly PATH_TO_COPY_APACHE_CONFIGURATION_FUNCTION=/docker-entrypoint-functions/tests/apache/copy-apache-configuration-test.sh
readonly PATH_TO_START_HTTPD_FUNCTION=/docker-entrypoint-functions/tests/apache/start-httpd-test.sh
readonly PATH_TO_CREATE_APP_USER_AND_GROUP_FUNCTION=/docker-entrypoint-functions/tests/general/create-app-user-and-group-test.sh
readonly PATH_TO_COMMIT_HASH_FUNCTION=/docker-entrypoint-functions/tests/general/show-commit-hash-test.sh
readonly PATH_TO_SET_CONTAINER_AS_INITIALIZED_FUNCTION=/docker-entrypoint-functions/tests/general/set-container-as-initialized-test.sh
readonly PATH_TO_COPY_PHP_FPM_CONFIGURATION_FUNCTION=/docker-entrypoint-functions/tests/php-fpm/copy-php-fpm-configuration-test.sh
readonly PATH_TO_START_PHPFPM_FUNCTION=/docker-entrypoint-functions/tests/php-fpm/start-php-fpm-test.sh
readonly PATH_TO_CREATE_SYMFONY_3_PARAMETERS_FILE_FUNCTION=/docker-entrypoint-functions/tests/symfony/create-symfony3-parameters-file-from-env-variable-test.sh

# https://github.com/ralish/bash-script-template/blob/stable/template.sh
set -o errexit  # Exit on most errors (see the manual)
set -o pipefail # Use last non-zero exit code in a pipelines

# DESC: Stops and removes a container with a specified name only if it is already running.
function stop_and_remove_container_by_name() {
  CONTAINER_NAME_TO_REMOVE=$1

  if [ -n "$(docker ps -aq -f name=${CONTAINER_NAME_TO_REMOVE})" ]; then
    echo "Stop and remove ${CONTAINER_NAME_TO_REMOVE} container..."
    docker rm -f "${CONTAINER_NAME_TO_REMOVE}"  > /dev/null 2>&1
  fi
}

# DESC: Waits until the container is completely bootstrapped.
function wait_until_container_is_completely_bootstrapped() {
  CONTAINER_NAME_TO_WAIT=$1

  echo "Wait for ${CONTAINER_NAME_TO_WAIT} to be completely initialized..."
  docker exec "${CONTAINER_NAME_TO_WAIT}" bash -c 'for i in {1..600}; do if [[ -f '/.initialized' ]]; then break; fi; sleep 1; done;'
}

# DESC: Builds the required Docker image.
function build_image() {
  IMAGE_NAME=$1
  PATH_TO_DOCKERFILE=$2

  echo "Build ${IMAGE_NAME} image..."
  docker build -t "${IMAGE_NAME}" -f "${PATH_TO_DOCKERFILE}" . > /dev/null 2>&1
}