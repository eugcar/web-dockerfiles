# DESC: Assert that the "app" user exists with the provided ID.
function assertAppUserId() {
  echo "-> assertAppUserId"

  USER_ID_TO_CHECK=$1

  if [[ $(id -u app) -ne "${USER_ID_TO_CHECK}" ]]; then
    echo "There is no user with ID ${USER_ID_TO_CHECK}."
    return 1
  fi

  return 0
}

# DESC: Assert that the "app" group exists with the provided ID.
function assertAppGroupId() {
  echo "-> assertAppGroupId"

  GROUP_ID_TO_CHECK=$1

  if [[ $(id -g app) -ne "${GROUP_ID_TO_CHECK}" ]]; then
    echo "There is no group with ID ${GROUP_ID_TO_CHECK}."
    return 1
  fi

  return 0
}