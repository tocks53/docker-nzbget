#!/bin/bash
umask 000

exec nzbget -s -c /config/nzbget.conf
