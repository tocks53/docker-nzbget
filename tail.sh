#!/bin/bash

exec /sbin/setuser nobody tail -F /config/log/nzbget.log
