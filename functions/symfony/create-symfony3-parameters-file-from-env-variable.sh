readonly APP_CONFIG_FOLDER_PATH='/var/www/html/app/config'
readonly APP_PARAMETERS_FILE_PATH=${APP_CONFIG_FOLDER_PATH}'/parameters.yml'

# DESC: Creates app parameters file using provided environment variables. If the file is already present keep it.
function create_symfony3_parameters_file_from_env_variable() {
  echo "Check application parameters file..."

  if [[ -z "${ENCODED_PARAMETERS_FILE}" && ! -e "${APP_PARAMETERS_FILE_PATH}" ]]; then
    echo "You have to either define ENCODED_PARAMETERS_FILE environment variable or provide the application with the parameters.yml file."
    exit 1
  fi

  if [[ -e "${APP_PARAMETERS_FILE_PATH}" ]]; then
    echo "The application has already its parameters.yml defined."
    return 0
  fi

  if [[ ! -d "${APP_CONFIG_FOLDER_PATH}" ]]; then
    mkdir -p "${APP_CONFIG_FOLDER_PATH}" && chown -R app:app "${APP_CONFIG_FOLDER_PATH}"
  fi

  runuser -l app -c "touch \"${APP_PARAMETERS_FILE_PATH}\""
  echo "${ENCODED_PARAMETERS_FILE}" | base64 -d > "${APP_PARAMETERS_FILE_PATH}"
}