#!/bin/bash

CHROME_ARGS="--disable-gpu --headless --no-sandbox --dbus-stub --remote-debugging-address=$DEBUG_ADDRESS --remote-debugging-port=$DEBUG_PORT --user-data-dir=/data"

# Add extra options to Chrome from environment variable CHROME_OPTS
if [ -n "$CHROME_OPTS" ]; then
  CHROME_ARGS="${CHROME_ARGS} ${CHROME_OPTS}"
fi

# install node_modules
exec sh -c "yarn install"

# Start Chrome
exec sh -c "/usr/bin/google-chrome-unstable $CHROME_ARGS"