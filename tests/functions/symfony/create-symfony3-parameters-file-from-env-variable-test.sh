readonly APP_CONFIG_FOLDER_PATH='/var/www/html/app/config'
readonly APP_PARAMETERS_FILE_PATH=${APP_CONFIG_FOLDER_PATH}'/parameters.yml'

# DESC: Assert that the symfony 3 parameters file exist and that its MD5 is correct.
function assertSymfony3ParametersFileIsPresent() {
  echo "-> assertSymfony3ParametersFileIsPresent"

  if [[ ! -f "${APP_PARAMETERS_FILE_PATH}" ]]; then
    echo "There is no file at path ${APP_PARAMETERS_FILE_PATH}."
    return 1
  fi

  MD5_SUM_TO_CHECK=$1

  ACTUAL_MD5_SUM=$(md5sum "${APP_PARAMETERS_FILE_PATH}" | cut -f 1 -d ' ')
  if [[ "${ACTUAL_MD5_SUM}" != "${MD5_SUM_TO_CHECK}" ]]; then
    echo "The provided value ${MD5_SUM_TO_CHECK} is different from the MD5 of the specified file that is ${ACTUAL_MD5_SUM}."
    return 1
  fi

  return 0
}