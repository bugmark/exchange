#!/usr/bin/env bash

# Restore the database

# FIXME: Rails Upgrade and PG 9.5 (ANDYL 12-Feb-2016)
#
# When working with PG 9.5 (as we are), Rails 4.2.3 mistakenly generates an
# an error message (pg_dump: invalid option 'i') when running db:migrate.
# BUT Rails upgrading to Rails 4.2.5 introduces other errors (sprockets, etc.)
# Workaround here was to send bad error txt to /dev/null.  :-(
#
# Action: upgrade to Rails 4.2.5 and fix the sprockets issues.
# Reference: https://gist.github.com/nruth/a3bc1b75281109b036e4

echo ------- start restore -------
date
echo -----------------------------
killall ruby > /dev/null 2>&1
echo "Restore database"
bundle exec rake data:restore:db
echo "Import development database"
bundle exec rake data:db:import db:migrate > /dev/null 2>&1
echo "Import test database"
RAILS_ENV=test bundle exec rake data:db:import db:migrate > /dev/null 2>&1
echo "Empty test database (runs slow...)"
RAILS_ENV=test bundle exec rails runner "TestClean.all"
echo "Restore system directory"
bundle exec rake data:restore:sysdir
echo ------- finish restore ------
date
echo -----------------------------
