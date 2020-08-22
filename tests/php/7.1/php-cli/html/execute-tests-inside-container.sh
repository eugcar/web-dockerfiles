#!/usr/bin/env bash

# https://github.com/ralish/bash-script-template/blob/stable/template.sh
set -o errexit  # Exit on most errors (see the manual)
set -o pipefail # Use last non-zero exit code in a pipeline

. /docker-entrypoint-functions/tests/general/show-commit-hash-test.sh
. /docker-entrypoint-functions/tests/general/create-app-user-and-group-test.sh
. /docker-entrypoint-functions/tests/symfony/create-symfony3-parameters-file-from-env-variable-test.sh
. /docker-entrypoint-functions/tests/general/set-container-as-initialized-test.sh

# DESC: Checks last operation status code and if needed exit with bad status code.
function exit_if_test_failed() {
  if [[ "$?" -ne 0 ]]; then
    exit 1
  fi
}

echo -e "\n\nExecute following tests:\n"

assertCommitHash ABCDE123456
exit_if_test_failed

assertAppUserId 1000
exit_if_test_failed

assertAppGroupId 1000
exit_if_test_failed

assertSymfony3ParametersFileIsPresent 2a9f589e41af454cf707927ab982f53d
exit_if_test_failed

assertIsInitialized
exit_if_test_failed

