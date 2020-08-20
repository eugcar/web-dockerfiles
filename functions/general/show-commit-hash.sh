# DESC: Show commit hash using provided environment variables.
function show_commit_hash() {
  if [[ -z "${COMMIT_HASH}" ]]; then
    echo "The COMMIT_HASH environment variables is not present."
    return 0
  fi

  echo "The commit hash is: ${COMMIT_HASH}"
}