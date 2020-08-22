readonly INITIALIZED_FILE_PATH='/.initialized'

# DESC: Asserts that the container is correctly initialized.
function assertIsInitialized() {
  echo "-> assertIsInitialized"

  if [[ ! -e "${INITIALIZED_FILE_PATH}" ]]; then
    echo "There is no file at path ${INITIALIZED_FILE_PATH}."
    return 1
  fi

  return 0
}