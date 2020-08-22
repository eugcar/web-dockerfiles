#!/usr/bin/env bash

# https://github.com/ralish/bash-script-template/blob/stable/template.sh
set -o errexit  # Exit on most errors (see the manual)
set -o pipefail # Use last non-zero exit code in a pipeline

. ../../../base.sh

# Environment file
. test.env

# DESC: Initializes the script.
function script_init() {
  readonly CONTAINER_NAME=www_centos77_test
  readonly CONTAINER_TO_BUILD=ecarocci/base:centos7.7
  readonly CONTAINER_TO_TEST=ecarocci/www:centos7.7
  readonly PATH_TO_TESTS_FUNCTIONS_FOLDER=$(realpath ../../../functions)
}

# DESC: Builds the required images.
function build_required_images() {
  cd ../../../..
  build_image "${CONTAINER_TO_BUILD}" ./images/base/centos/7.7/base/Dockerfile
  build_image "${CONTAINER_TO_TEST}"  ./images/apache/centos/7.7/Dockerfile
  cd -  > /dev/null 2>&1
}

# DESC: Runs test image.
function run_test_image() {
  echo "Run ${CONTAINER_NAME} image..."
  docker run --detach --interactive --tty --env-file test.env --volume="${PATH_TO_TESTS_FUNCTIONS_FOLDER}"/:/docker-entrypoint-functions/tests/ --volume="${PWD}"/conf/:/docker-entrypoint-init.d/ --name "${CONTAINER_NAME}" "${CONTAINER_TO_TEST}" > /dev/null 2>&1
}

# DESC: Executes tests on the container
function execute_tests() {
  echo "Execute following tests:"
  docker exec "${CONTAINER_NAME}" bash -c ". ${PATH_TO_COMMIT_HASH_FUNCTION} && assertCommitHash ${COMMIT_HASH}"
  docker exec "${CONTAINER_NAME}" bash -c ". ${PATH_TO_CREATE_APP_USER_AND_GROUP_FUNCTION} && assertAppUserId ${HOST_USER_ID}"
  docker exec "${CONTAINER_NAME}" bash -c ". ${PATH_TO_CREATE_APP_USER_AND_GROUP_FUNCTION} && assertAppGroupId ${HOST_GROUP_ID}"
  docker exec "${CONTAINER_NAME}" bash -c ". ${PATH_TO_COPY_APACHE_CONFIGURATION_FUNCTION} && assertVirtualHostMd5Sum ${VIRTUAL_HOST_FILENAME_TO_CHECK} ${MD5_SUM_TO_CHECK}"
  docker exec "${CONTAINER_NAME}" bash -c ". ${PATH_TO_START_HTTPD_FUNCTION} && assertIsHttpdRunning"
  docker exec "${CONTAINER_NAME}" bash -c ". ${PATH_TO_SET_CONTAINER_AS_INITIALIZED_FUNCTION} && assertIsInitialized"
}

# DESC: Builds and runs the container under test then executes test and in the end stops and removes it.
main() {
  script_init

  echo "Execute tests on ${CONTAINER_TO_TEST} image..."

  stop_and_remove_container_by_name "${CONTAINER_NAME}"
  build_required_images
  run_test_image
  wait_until_container_is_completely_bootstrapped "${CONTAINER_NAME}"
  execute_tests
  stop_and_remove_container_by_name "${CONTAINER_NAME}"
}

main "$@"
