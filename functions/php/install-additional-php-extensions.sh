readonly PHP_REQUIRED_EXTENSIONS_FILE_PATH='/docker-entrypoint-init.d/php_extensions'

# DESC: Install additional PHP extensions.
function install_additional_php_extensions() {
  echo "Install additional PHP extensions..."

  yum update -y

  if [[ ! -e "${PHP_REQUIRED_EXTENSIONS_FILE_PATH}" ]]; then
    echo "You have not defined a file containing additional PHP extensions at path ${PHP_REQUIRED_EXTENSIONS_FILE_PATH}."
    return 0
  fi

  # https://stackoverflow.com/questions/10929453/read-a-file-line-by-line-assigning-the-value-to-a-variable
  while IFS= read -r php_extension; do
    echo "Install ${php_extension}"
    yum install "${php_extension}" -y
  done < ${PHP_REQUIRED_EXTENSIONS_FILE_PATH}
}