#!/bin/bash
umask 000

exec nzbget -D -c /config/nzbget.conf
