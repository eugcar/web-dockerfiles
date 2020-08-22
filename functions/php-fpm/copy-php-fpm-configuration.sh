readonly PHPFPM_CONFIGURATION_PATH='/docker-entrypoint-init.d/php-fpm'
readonly PHPFPM_POOL_CONFIGURATION_PATH='/docker-entrypoint-init.d/php-fpm/pools'

# DESC: Copies PHP-FPM configuration.
function copy_php_fpm_configuration() {
  PHP_FPM_ROOT_DIRECTORY=/etc

  if [[ -d $1  ]]; then
    PHP_FPM_ROOT_DIRECTORY=$1
  fi

  # PHP-FPM main folder
  if [[ -d "${PHPFPM_CONFIGURATION_PATH}" ]]; then
    if [[ -e "${PHPFPM_CONFIGURATION_PATH}/php-fpm.conf" ]]; then
      echo "Copy ${PHPFPM_CONFIGURATION_PATH}/php-fpm.conf to ${PHP_FPM_ROOT_DIRECTORY}/php-fpm.conf"
      \cp ${PHPFPM_CONFIGURATION_PATH}/php-fpm.conf "${PHP_FPM_ROOT_DIRECTORY}"/php-fpm.conf
    fi
    # PHP-FPM pools folder
    if [[ -d "${PHPFPM_POOL_CONFIGURATION_PATH}" ]]; then
      for phpfpm_pool_configuration in "${PHPFPM_POOL_CONFIGURATION_PATH}"/*.conf; do
        [ -e "$phpfpm_pool_configuration" ] || continue
        echo "Copy ${phpfpm_pool_configuration} in ${PHP_FPM_ROOT_DIRECTORY}/php-fpm.d folder."
        \cp "$phpfpm_pool_configuration" "${PHP_FPM_ROOT_DIRECTORY}"/php-fpm.d/
      done
    else
      echo "You have not defined a directory containing additional PHP-FPM pools configuration at path ${PHPFPM_POOL_CONFIGURATION_PATH}."
    fi
  else
    echo "You have not defined a directory containing additional PHP-FPM configuration at path ${PHPFPM_CONFIGURATION_PATH}."
  fi
}