readonly APACHE_CONFIGURATION_PATH='/docker-entrypoint-init.d/httpd'
readonly APACHE_VHOST_CONFIGURATION_PATH='/docker-entrypoint-init.d/httpd/conf.d'
readonly APACHE_MODULES_CONFIGURATION_PATH='/docker-entrypoint-init.d/httpd/conf.modules.d'

# DESC: Assert that the virtual host file exists and that its MD5 is correct.
function assertVirtualHostMd5Sum() {
  echo "-> assertVirtualHostMd5Sum"

  VIRTUAL_HOST_FILE_NAME_TO_CHECK=$1
  MD5_SUM_TO_CHECK=$2

  PATH_TO_CHECK=${APACHE_VHOST_CONFIGURATION_PATH}/${VIRTUAL_HOST_FILE_NAME_TO_CHECK}
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