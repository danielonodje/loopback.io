#!/bin/bash

ORG=strongloop
REPO=loopback-next
DOCS=./pages/en/lb4
BRANCH=master
ARCHIVE_NAME="loopback-next-$BRANCH"

mkdir -p $DOCS
# pull down all the markdown files (reserving dir structure)
# given the GitHub ORG, REPO, and BRANCH
curl -L https://github.com/$ORG/$REPO/archive/$BRANCH.tar.gz | tar --strip-components 1 -C "$DOCS" --wildcards \
-xzvf- "$ARCHIVE_NAME/docs/*.md" "$ARCHIVE_NAME/packages/*.md" "$ARCHIVE_NAME/docs/*.png"

#the following has only one occurence, but can be generalized if there is more
sed -E -i 's/include previous.md/include previous.html/g' $DOCS/docs/*.md
