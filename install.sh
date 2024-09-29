#!/bin/sh

bundle install

ruby initial.rb

tail -f /dev/null
