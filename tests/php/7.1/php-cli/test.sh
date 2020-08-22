#!/usr/bin/env bash

# https://github.com/ralish/bash-script-template/blob/stable/template.sh
set -o errexit  # Exit on most errors (see the manual)
set -o pipefail # Use last non-zero exit code in a pipeline

. ../../../base.sh

# Environment file
. test.env

# DESC: Initializes the script.
function script_init() {
  readonly CONTAINER_NAME=php_cli_71_test
  readonly CONTAINER_TO_BUILD_0=ecarocci/base:centos7.6
  readonly CONTAINER_TO_BUILD_1=ecarocci/base:centos7.6-ius
  readonly CONTAINER_TO_TEST=ecarocci/php-cli:7.1
  readonly PATH_TO_TESTS_FUNCTIONS_FOLDER=$(realpath ../../../functions)
}

# DESC: Builds the required images.
function build_required_images() {
  cd ../../../..
  build_image "${CONTAINER_TO_BUILD_0}" ./images/base/centos/7.6/base/Dockerfile
  build_image "${CONTAINER_TO_BUILD_1}" ./images/base/centos/7.6/ius/Dockerfile
  build_image "${CONTAINER_TO_TEST}"    ./images/php/7.1/php-cli/Dockerfile
  cd -  > /dev/null 2>&1
}

# DESC: Executes tests on the container
function execute_tests() {
  docker run --interactive --env-file test.env --volume="${PATH_TO_TESTS_FUNCTIONS_FOLDER}"/:/docker-entrypoint-functions/tests/ --volume="${PWD}"/html/:/var/www/html --name "${CONTAINER_NAME}" "${CONTAINER_TO_TEST}" "bash" "execute-tests-inside-container.sh"
}

# DESC: Builds and runs the container under test then executes test and in the end stops and removes it.
main() {
  script_init

  echo "Execute tests on ${CONTAINER_TO_TEST} image..."

  stop_and_remove_container_by_name "${CONTAINER_NAME}"
  build_required_images
  execute_tests
}

main "$@"
