#!/usr/bin/env bash

check_eq() {
  local environment="$1"
  local command="$2"
  local expected="$3"

  local result="$(env NODE_ENV="${environment}" sh -c "./${command}" 2>&1)"
  if [[ $? -ne 0 ]]; then
    echo -e "\033[0;31m ✗ Failed\033[0m ${command}. ${result}"
    exit 2
  fi

  local pad='           '
  pad=${pad:0:11-${#environment}}

  if [[ "${expected}" == "${result}" ]]; then
    echo -e \
      '\033[0;32m ✓ Passed\033[0m' \
      "\033[0;37m[${environment}]\033[0m${pad}" \
      "${command}. \033[0;37mResult: ${result//$'\n'/↳}.\033[0m"
  else
    echo -e \
      '\033[0;31m ✗ Failed\033[0m' \
      "\033[0;37m[${environment}]\033[0m" \
      "${command}.\033[0;37m" \
      "Expected: ${expected//$'\n'/↳}," \
      "actual: \033[0;31m${result//$'\n'/↳}.\033[0m" >&2
    exit 2
  fi
}

set -e
cd "$(cd "$(dirname "$0")"; pwd)"

check_eq dev         'if-dev && echo 1' 1
check_eq dev         'if-dev && echo 1 && echo 2' $'1\n2'
check_eq development 'if-dev && echo 1' 1
check_eq prod        'if-dev && echo 1 || echo 2' 2
check_eq prod        'if-dev && echo 1 && echo 2 || echo 2' 2
check_eq prod        'if-not-dev && echo 1' 1
check_eq dev         'if-not-dev && echo 1 || echo 2' 2

check_eq prod        'if-prod && echo 1' 1
check_eq dev         'if-prod && echo 1 || echo 2' 2
check_eq dev         'if-not-prod && echo 1' 1
check_eq prod        'if-not-prod && echo 1 || echo 2' 2

check_eq ci          'if-env-is ci && echo 1' 1
check_eq dev         'if-env-is ci && echo 1 || echo 2' 2
check_eq dev         'if-not-env-is ci && echo 1' 1
check_eq ci          'if-not-env-is ci && echo 1 || echo 2' 2
