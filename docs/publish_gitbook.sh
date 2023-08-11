
# remove gitbook old things
rm -rf _book
rm -rf docs

# gitbook init
gitbook install && gitbook build

# build pages
mkdir docs
cp -R _book/* docs/

# delete things
git clean -fx _book
# upload
git add .
git commit -a -m "update docs-20230811-1"
git push -u origin main

## gitbook serve
