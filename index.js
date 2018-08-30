#!/usr/bin/env node

'use strict';
var path = require('path');

var environment = process.env['NODE_ENV'] || '';
var scriptName = path.basename(process.argv[1]);
var checkEnv = process.argv[2] || scriptName.split('-').pop();
var reverseCheck = scriptName.indexOf('-not') > -1;

var isEnvMatch = environment.indexOf(checkEnv) === (reverseCheck ? -1 : 0);
process.exit(isEnvMatch ? 0 : 1);
