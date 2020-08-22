readonly PHP_CONFIGURATION_PATH='/docker-entrypoint-init.d/php'
readonly PHP_EXTENSIONS_CONFIGURATION_PATH='/docker-entrypoint-init.d/php/php.d'

# DESC: Copies PHP configuration.
function copy_php_configuration() {
  PHP_ROOT_DIRECTORY=/etc

  if [[ -d $1  ]]; then
    PHP_ROOT_DIRECTORY=$1
  fi

  # PHP
  if [[ -d "${PHP_CONFIGURATION_PATH}" ]]; then
    if [[ -e "${PHP_CONFIGURATION_PATH}/php.ini" ]]; then
      echo "Copy ${PHP_CONFIGURATION_PATH}/php.ini to ${PHP_ROOT_DIRECTORY}/php.ini"
      \cp ${PHP_CONFIGURATION_PATH}/php.ini "${PHP_ROOT_DIRECTORY}"/php.ini
    fi
    # PHP extensions configuration folder
    if [[ -d "${PHP_EXTENSIONS_CONFIGURATION_PATH}" ]]; then
      for php_extension_configuration in "${PHP_EXTENSIONS_CONFIGURATION_PATH}"/*.ini; do
        [ -e "$php_extension_configuration" ] || continue
        echo "Copy ${php_extension_configuration} in ${PHP_ROOT_DIRECTORY}/php.d folder."
        \cp "$php_extension_configuration" "${PHP_ROOT_DIRECTORY}"/php.d/
      done
    else
      echo "You have not defined a directory containing additional PHP extensions configuration at path ${PHP_EXTENSIONS_CONFIGURATION_PATH}."
    fi
  else
    echo "You have not defined a directory containing additional PHP configuration at path ${PHP_CONFIGURATION_PATH}."
  fi
}