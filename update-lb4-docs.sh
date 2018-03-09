#!/bin/bash

org=strongloop
repo=loopback-next
target=pages/en/lb4
branch=move-docs-into-monorepo
tmp=$target/tempdir

mkdir -p $tmp
# pull down all the markdown files (reserving dir structure)
# given the GitHub org, repo, and branch
curl -L https://github.com/$org/$repo/archive/$branch.tar.gz \
   | tar --strip-components 1 -C $tmp -xzf- '*.md'

cp -R $tmp/packages $target/readmes/$repo
#rename relative link extensions from md to html
sed -E -i '' 's/\(([^(]+)\.md/(\1.html/g' $tmp/docs/*.md
#the following has only one occurence, but can be generalized if there is more
sed -E -i '' 's/include previous.md/include previous.html/g' $tmp/docs/*.md

mv $tmp/docs/*.md $target
rm -rf $tmp
