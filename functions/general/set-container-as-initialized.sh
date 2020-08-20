readonly INITIALIZED_FILE_PATH='/.initialized'

# DESC: Sets container as initialized
function set_container_as_initialized() {
  touch ${INITIALIZED_FILE_PATH}
}