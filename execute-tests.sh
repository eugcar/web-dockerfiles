#!/usr/bin/env bash

# https://github.com/ralish/bash-script-template/blob/stable/template.sh
set -o errexit  # Exit on most errors (see the manual)
set -o pipefail # Use last non-zero exit code in a pipeline

readonly DEFAULT_TEST_SCRIPT_NAME=test.sh

# DESC: Tests a Docker image using its related script.
function testImage() {
  FOLDER_TO_TEST_SCRIPT=$1

  cd "${FOLDER_TO_TEST_SCRIPT}" > /dev/null 2>&1

  ./"${DEFAULT_TEST_SCRIPT_NAME}"

  if [[ "$?" -ne 0 ]]; then
    echo -e '\n\n'
    echo '--------------------------------------------------------------------------------'
    echo '|                                                                              |'
    echo '|                   !!!!! T E S T S    F A I L E D !!!!!                       |'
    echo '|                                                                              |'
    echo '--------------------------------------------------------------------------------'
    exit 1
  fi

  cd -  > /dev/null 2>&1

  echo '--------------------------------------------------------------------------------'
  echo '--------------------------------------------------------------------------------'
}

echo '--------------------------------------------------------------------------------'
echo '|                                                                              |'
echo '|                    D O C K E R    I M A G E S    T E S T S                   |'
echo '|                                                                              |'
echo '--------------------------------------------------------------------------------'
echo -e '\n\n'

testImage tests/apache/centos/7.6
testImage tests/apache/centos/7.7
testImage tests/php/7.1/php-cli
testImage tests/php/7.1/php-fpm/apache
testImage tests/php/7.1/php-fpm/base
testImage tests/php/7.1/php-fpm/symfony-3
testImage tests/php/7.4/php-cli
testImage tests/php/7.4/php-fpm/apache
testImage tests/php/7.4/php-fpm/base
testImage tests/php/7.4/php-fpm/symfony-3

echo -e '\n\n'
echo '--------------------------------------------------------------------------------'
echo '|                                                                              |'
echo '|                      A L L    T E S T S    P A S S E D                       |'
echo '|                                                                              |'
echo '--------------------------------------------------------------------------------'

exit 0