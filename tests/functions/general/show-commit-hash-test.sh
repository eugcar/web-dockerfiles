# DESC: Assert that commit hash environment variable is equal to provided value.
function assertCommitHash() {
  echo "-> assertCommitHash"

  if [[ -z "${COMMIT_HASH}" ]]; then
    echo "The COMMIT_HASH environment variables is not present."
    return 1
  fi

  COMMIT_HASH_TO_CHECK=$1

  if [[ "${COMMIT_HASH_TO_CHECK}" -ne "${COMMIT_HASH}" ]]; then
    echo "The provided value ${COMMIT_HASH_TO_CHECK} is different from the COMMIT_HASH environment variable ${COMMIT_HASH}."
    return 1
  fi

  return 0
}