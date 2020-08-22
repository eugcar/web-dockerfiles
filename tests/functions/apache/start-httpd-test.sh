readonly HTTPD_PID_FILE_PATH='/run/httpd/httpd.pid'

# DESC: Asserts that HTTPD is running.
function assertIsHttpdRunning() {
  echo "-> assertIsHttpdRunning"

  if [[ ! -e "${HTTPD_PID_FILE_PATH}" ]]; then
    echo "There is no file at path ${HTTPD_PID_FILE_PATH}."
    return 1
  fi

  return 0
}