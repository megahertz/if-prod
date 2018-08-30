#!/bin/sh

case "${0}" in
  *not-dev)  [[ "${NODE_ENV}" != dev*  ]] && "$@" ;;
  *not-prod) [[ "${NODE_ENV}" != prod* ]] && "$@" ;;
  *not-test) [[ "${NODE_ENV}" != test* ]] && "$@" ;;
  *dev)      [[ "${NODE_ENV}" == dev*  ]] && "$@" ;;
  *prod)     [[ "${NODE_ENV}" == prod* ]] && "$@" ;;
  *test)     [[ "${NODE_ENV}" == test* ]] && "$@" ;;
esac
