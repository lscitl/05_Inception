#!/bin/sh

if [ "`echo ping | redis-cli -h $REDIS_HOST -a $REDIS_PW`" != "PONG" ]; then
    exit 1
fi