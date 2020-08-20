#!/usr/bin/env bash

# https://github.com/ralish/bash-script-template/blob/stable/template.sh
set -o errexit  # Exit on most errors (see the manual)
set -o pipefail # Use last non-zero exit code in a pipeline

. /docker-entrypoint-functions/apache/copy-apache-configuration.sh
. /docker-entrypoint-functions/apache/start-httpd.sh
. /docker-entrypoint-functions/general/create-app-user-and-group.sh
. /docker-entrypoint-functions/general/execute-scripts.sh
. /docker-entrypoint-functions/general/set-container-as-initialized.sh
. /docker-entrypoint-functions/general/show-commit-hash.sh

# DESC: Initializes the container.
initialize() {
  show_commit_hash
  create_user_and_group
  copy_apache_configuration
  execute_scripts
  set_container_as_initialized
}

# DESC: Checks whether the container is initialized or not. If not, initializes it. After that run httpd.
main() {
  if [[ ! -e "${INITIALIZED_FILE_PATH}" ]]; then
    echo "Initialize Apache container..."
    initialize
  else
    echo "Apache container is already initialized."
  fi

  start_httpd
}

main "$@"