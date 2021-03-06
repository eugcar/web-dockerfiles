#!/usr/bin/env bash

# https://github.com/ralish/bash-script-template/blob/stable/template.sh
set -o errexit  # Exit on most errors (see the manual)
set -o pipefail # Use last non-zero exit code in a pipeline

. /docker-entrypoint-functions/general/create-app-user-and-group.sh
. /docker-entrypoint-functions/general/execute-scripts.sh
. /docker-entrypoint-functions/general/set-container-as-initialized.sh
. /docker-entrypoint-functions/general/show-commit-hash.sh
. /docker-entrypoint-functions/php/copy-php-configuration.sh
. /docker-entrypoint-functions/php/install-additional-php-extensions.sh
. /docker-entrypoint-functions/symfony/create-symfony3-parameters-file-from-env-variable.sh

# DESC: Initializes the container.
initialize() {
  show_commit_hash
  create_user_and_group
  install_additional_php_extensions
  copy_php_configuration
  create_symfony3_parameters_file_from_env_variable
  execute_scripts
  set_container_as_initialized
}

# DESC: Checks whether the container is initialized or not. If not, initializes it. After that run php.
main() {
  if [[ ! -e "${INITIALIZED_FILE_PATH}" ]]; then
    echo "Initialize PHP container..."
    initialize
  else
    echo "PHP container is already initialized."
  fi

  exec "$@"
}

main "$@"