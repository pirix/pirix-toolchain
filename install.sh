#!/bin/bash

. ./config.sh

mkdir -p $PREFIX
cp -r $DESTDIR/$PREFIX/* $PREFIX
