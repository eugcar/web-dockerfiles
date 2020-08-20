readonly SCRIPTS_PATH='/docker-entrypoint-init.d/scripts'

# DESC: Executes additional scripts.
function execute_scripts() {
  if [[ -d "${SCRIPTS_PATH}" ]]; then
    for script in "${SCRIPTS_PATH}"/*.sh; do
      if [[ -x "${script}" ]]; then
        echo "Running ${script}."
        . "${script}"
      else
        echo "Script ${script} is not executable. It will be skipped."
      fi
    done
  else
    echo "You have not defined a directory containing additional scripts at path ${SCRIPTS_PATH}."
  fi
}