#!/usr/bin/env bash

pid=0

# SIGTERM-handler
term_handler() {
  if [ $pid -ne 0 ]; then
    kill -SIGTERM "$pid"
    wait "$pid"
  fi
  exit 143; # 128 + 15 -- SIGTERM
}

# on SIGTERM, kill the last background process, which is `tail -f /dev/null`
# and execute term_handler
trap 'kill ${!}; term_handler' SIGTERM

# the redirection trick makes sure that $! is the pid
# of the "node build/index.js" process
node build/index.js > >(./node_modules/.bin/pino-pretty -t) &
pid="$!"

# wait forever
while true
do
  tail -f /dev/null & wait ${!}
done
