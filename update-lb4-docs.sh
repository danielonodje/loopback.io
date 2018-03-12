#!/bin/bash

org=strongloop
repo=loopback-next
target=pages/en/lb4
branch=move-docs-into-monorepo
archive_name="loopback-next-$branch"

mkdir -p $target
# pull down all the markdown files (reserving dir structure)
# given the GitHub org, repo, and branch
curl -L  https://github.com/$org/$repo/archive/$target.tar.gz | tar --strip-components 1 -C "$DOCS" --wildcards \
-xzvf- "$archive_name/docs/*.md" "$archive_name/packages/*.md" "$archive_name/docs/*.png"

cp -R $target/packages $target/readmes/$repo
#the following has only one occurence, but can be generalized if there is more
sed -E -i 's/include previous.md/include previous.html/g' $target/docs/*.md
