#!/usr/bin/env bash
# this is meant to be run on the dev machine
# not the production server
#
# to just grab the database:
# cap ln6 backup:generate:db backup:download:db
#
echo "||||||||||||||||||||||||||||"
echo ------- start backup -------
date
echo ----------------------------
current_branch=`git rev-parse --abbrev-ref HEAD`
if [ "$current_branch" != "master" ]; then
  echo checkout master branch
  git stash > /dev/null 2>&1
  git checkout master   2>&1
fi
echo ----------------------------
bundle exec cap ln6 backup:generate:all
bundle exec cap ln6 backup:download:all
if [ "$current_branch" != "master" ]; then
  echo revert $current_branch branch
  git stash pop > /dev/null 2>&1
  git checkout $current_branch
fi
echo ------- finish backup ------
date
echo ----------------------------

