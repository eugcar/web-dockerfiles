readonly PHPFPM_CONFIGURATION_PATH='/docker-entrypoint-init.d/php-fpm'
readonly PHPFPM_POOL_CONFIGURATION_PATH='/docker-entrypoint-init.d/php-fpm/pools'

# DESC: Assert that the PHP-FPM pool file exists and that its MD5 is correct.
function assertPhpFpmPoolMd5Sum() {
  echo "-> assertPhpFpmPoolMd5Sum"

  PHPFPM_POOL_FILE_NAME_TO_CHECK=$1
  MD5_SUM_TO_CHECK=$2

  PATH_TO_CHECK=${PHPFPM_POOL_CONFIGURATION_PATH}/${PHPFPM_POOL_FILE_NAME_TO_CHECK}
  if [[ ! -f "${PATH_TO_CHECK}" ]]; then
    echo "There is no file at path ${PATH_TO_CHECK}."
    return 1
  fi

  ACTUAL_MD5_SUM=$(md5sum "${PATH_TO_CHECK}" | cut -f 1 -d ' ')
  if [[ "${ACTUAL_MD5_SUM}" != "${MD5_SUM_TO_CHECK}" ]]; then
    echo "The provided value ${MD5_SUM_TO_CHECK} is different from the MD5 of the specified file that is ${ACTUAL_MD5_SUM}."
    return 1
  fi

  return 0
}