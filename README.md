# if-prod
[![Build Status](https://travis-ci.org/megahertz/if-prod.svg?branch=master)](https://travis-ci.org/megahertz/if-prod)
[![NPM version](https://badge.fury.io/js/if-prod.svg)](https://badge.fury.io/js/if-prod)
[![Dependencies status](https://david-dm.org/megahertz/if-prod/status.svg)](https://david-dm.org/megahertz/if-prod)

## Description

This tiny script allows to simplify conditional statements which check
for the current environment from $NODE_ENV. Consider the following
package.json:

```json
"scripts": {
  "start": "if [[ \"${NODE_ENV}\" == \"production\" ]]; then node dist/server.js; else webpack --watch; fi",
}
```

The following code is hard for reading and doesn't work on Windows. It
can be simplified using this package:

```json
"scripts": {
  "start": "if-prod && node dist/server.js || webpack --watch",
}
```

## Installation

Install with [npm](https://npmjs.org/package/if-prod):

    npm install if-prod

## Usage

There are the following commands in this package:

 - if-prod
 - if-dev
 - if-env-is ENVIRONMENT NAME
 - if-not-prod
 - if-not-dev
 - if-not-env-is ENVIRONMENT NAME

### Examples

- **if/then/else**
  `if-prod && node dist/server.js || webpack --watch`

- **single if**
  `if-prod && node dist/server.js || true` - without `|| true` this
  command returns status code 1 if the current environment is
  not "production"

- **if not**
  `if-not-prod && rm -rf dist || true` - run in all environment except
  "production"

- **custom environment**
  `if-env-is test && rm -rf coverage || true`

## Related projects

[ericclemmons/if-env](https://github.com/ericclemmons/if-env) - almost
the same approach but can check for any environment variables, not only
$NODE_ENV

[ericclemmons/per-env](https://github.com/ericclemmons/per-env) -
environment-driven npm scripting

## License

Licensed under MIT.
