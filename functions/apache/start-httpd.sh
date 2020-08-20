readonly HTTPD_PID_FILE_PATH='/run/httpd/httpd.pid'

# DESC: Starts httpd.
function start_httpd() {
  echo "Start httpd..."

  # Apache won't start if the PID file already exists for any reason.
  rm -rf "${HTTPD_PID_FILE_PATH}"

  /usr/sbin/httpd -D FOREGROUND
}