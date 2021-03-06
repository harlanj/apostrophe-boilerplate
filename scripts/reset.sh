#!/bin/sh
KEEP_PAGES=(default.html home.html insufficient.html notfound.html)
REMOVE_MODULES=(apostrophe-map apostrophe-twitter)

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_DIR=$DIR/..
pushd $PROJECT_DIR

# clear out public assets
rm -rf ./.git
rm -f $(find ./public/css/ -type f | grep -v site.less)
rm -f ./public/images/*
rm -rf ./public/modules/*
rm -f ./uploads/files/*

# clear out views
grepstring="${KEEP_PAGES[0]}"
KEEP_PAGES=("${KEEP_PAGES[@]:1}") 
for page in "${KEEP_PAGES[@]}"; do
  grepstring="${grepstring}\|${page}"
done
rm -f $(find ./views/pages -type f | grep -v $grepstring)

# remove unnecessary npm modules
for module in "${REMOVE_MODULES[@]}"; do
  npm uninstall --save $module
done

# prep it
# mkdir -p ./public/css/style/
# echo "// Override and add styles here" > ./public/css/style/content.less
# echo "@import 'utilities/reset.less;'\n@import 'style/content.less;'" > ./public/css/site.less

popd $PROJECT_DIR