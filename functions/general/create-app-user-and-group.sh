# DESC: Creates both user and group using provided ennvironment variables.
function create_user_and_group() {
  echo "Create both user and group..."

  if [[ $(id -u app > /dev/null 2>&1; echo $?) == "0" ]]; then
    echo "User app already exists."
    return 0
  fi

  if [[ -z "${HOST_USER_ID}" || -z "${HOST_GROUP_ID}" ]]; then
    echo "You have to define both HOST_USER_ID and HOST_GROUP_ID environment variables."
    exit 1
  fi

  groupadd -g "${HOST_GROUP_ID}" app && useradd -u "${HOST_USER_ID}" -g app -s /bin/bash app
}