#!/usr/bin/env bash

#DEFAULT_VERSION="5.4.0.git"
DEFAULT_VERSION="5.4.0.g$(git rev-parse --short HEAD).ddn1"

#VERSION="`git describe 2> /dev/null | sed -e 's/^collectd-//'`"

if test -z "$VERSION"; then
	VERSION="$DEFAULT_VERSION"
fi

VERSION="`echo \"$VERSION\" | sed -e 's/-/./g'`"

echo -n "$VERSION"
