# DESC: Asserts that PHP-FPM is running.
function assertIsPhpFpmRunning() {
  echo "-> assertIsPhpFpmRunning"

  PHPFPM_PID_FILE_PATH=$1

  if [[ ! -e "${PHPFPM_PID_FILE_PATH}" ]]; then
    echo "There is no file at path ${PHPFPM_PID_FILE_PATH}."
    return 1
  fi

  return 0
}