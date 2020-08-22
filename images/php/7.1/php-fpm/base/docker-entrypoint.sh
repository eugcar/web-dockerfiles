#!/usr/bin/env bash

# https://github.com/ralish/bash-script-template/blob/stable/template.sh
set -o errexit  # Exit on most errors (see the manual)
set -o pipefail # Use last non-zero exit code in a pipeline

. /docker-entrypoint-functions/general/add-bitbucket-to-known-hosts.sh
. /docker-entrypoint-functions/general/create-app-user-and-group.sh
. /docker-entrypoint-functions/general/execute-scripts.sh
. /docker-entrypoint-functions/general/set-container-as-initialized.sh
. /docker-entrypoint-functions/general/show-commit-hash.sh
. /docker-entrypoint-functions/php/copy-php-configuration.sh
. /docker-entrypoint-functions/php/install-additional-php-extensions.sh
. /docker-entrypoint-functions/php-fpm/copy-php-fpm-configuration.sh


# DESC: Initializes the container.
initialize() {
  show_commit_hash
  create_user_and_group
  add_bitbucket_to_known_hosts
  install_additional_php_extensions
  copy_php_configuration
  copy_php_fpm_configuration
  execute_scripts
  set_container_as_initialized
}

# DESC: Checks whether the container is initialized or not. If not, initializes it. After that run php-fpm.
main() {
  if [[ ! -e "${INITIALIZED_FILE_PATH}" ]]; then
    echo "Initialize PHP-FPM-BASE container..."
    initialize
  else
    echo "PHP-FPM-BASE container is already initialized."
  fi

  echo "Start php-fpm..."
  php-fpm
}

main "$@"