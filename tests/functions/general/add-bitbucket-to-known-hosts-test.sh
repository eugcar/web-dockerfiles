readonly PATH_TO_SSH_FOLDER=/home/app/.ssh
readonly PATH_TO_KNOWN_HOSTS=${PATH_TO_SSH_FOLDER}/known_hosts

# DESC: Asserts that bitbucket.org is added to known hosts.
function assertBitbucketIsAddedToKnownHosts() {
  echo "-> assertBitbucketIsAddedToKnownHosts"

  if [[ ! -f "${PATH_TO_KNOWN_HOSTS}" ]]; then
    echo "There is no file at path ${PATH_TO_KNOWN_HOSTS}."
    return 1
  fi

  if [[ $(grep -c "bitbucket.org" "${PATH_TO_KNOWN_HOSTS}") -ne 1 ]]; then
    echo "Bitbucket.org has not been added to ${PATH_TO_KNOWN_HOSTS}."
    return 1
  fi

  return 0
}