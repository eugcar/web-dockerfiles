readonly APACHE_CONFIGURATION_PATH='/docker-entrypoint-init.d/httpd'
readonly APACHE_VHOST_CONFIGURATION_PATH='/docker-entrypoint-init.d/httpd/conf.d'
readonly APACHE_MODULES_CONFIGURATION_PATH='/docker-entrypoint-init.d/httpd/conf.modules.d'

# DESC: Copies Apache configuration.
function copy_apache_configuration() {
  if [[ -d "${APACHE_CONFIGURATION_PATH}" ]]; then
    if [[ -e "${APACHE_CONFIGURATION_PATH}/httpd.conf" ]]; then
      echo "Copy ${APACHE_CONFIGURATION_PATH}/httpd.conf to /etc/httpd/conf/httpd.conf"
      \cp ${APACHE_CONFIGURATION_PATH}/httpd.conf /etc/httpd/conf/httpd.conf
    fi
    # Apache vhost configuration folder
    if [[ -d "${APACHE_VHOST_CONFIGURATION_PATH}" ]]; then
      for apache_vhost_configuration in "${APACHE_VHOST_CONFIGURATION_PATH}"/*.conf; do
        [ -e "$apache_vhost_configuration" ] || continue
        echo "Copy ${apache_vhost_configuration} in /etc/httpd/conf.d folder."
        \cp "$apache_vhost_configuration" /etc/httpd/conf.d/
      done
    else
      echo "You have not defined a directory containing additional Apache vhost configuration at path ${APACHE_VHOST_CONFIGURATION_PATH}."
    fi
    # Apache modules configuration folder
    if [[ -d "${APACHE_MODULES_CONFIGURATION_PATH}" ]]; then
      for apache_modules_configuration in "${APACHE_MODULES_CONFIGURATION_PATH}"/*.conf; do
        [ -e "$apache_modules_configuration" ] || continue
        echo "Copy ${apache_modules_configuration} in /etc/httpd/conf.modules.d folder."
        \cp "$apache_modules_configuration" /etc/httpd/conf.modules.d/
      done
    else
      echo "You have not defined a directory containing additional Apache modules configuration at path ${APACHE_MODULES_CONFIGURATION_PATH}."
    fi
  else
    echo "You have not defined a directory containing additional Apache configuration at path ${APACHE_CONFIGURATION_PATH}."
  fi
}