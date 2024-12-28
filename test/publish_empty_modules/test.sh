#!/bin/sh

set -eu

GLEAM_COMMAND=${GLEAM_COMMAND:-"cargo run --quiet --"}

g() {
	echo "Running: $GLEAM_COMMAND $@"
	$GLEAM_COMMAND "$@"
}

echo Resetting the build directory to get to a known state
rm -fr build

echo Running publish should not publish anything
output=$(yes "n" | g publish)
if echo "$output" | grep -q "The package modules does not export anything"; then
    echo "Publish was correctly prevented with error"
else
    echo "Expected publish to be aborted"
    exit 1
fi

echo
echo Success! 💖
echo
