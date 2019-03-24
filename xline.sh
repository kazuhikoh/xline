#!/bin/bash

# options
OPTION_COMPACT_OUTPUT=false
while getopts c opts
do
  case $opts in
  c)  
    OPTION_COMPACT_OUTPUT=true
  ;;  
  \?) 
    exit 1
  esac
done
shift $((OPTIND - 1))

readonly TIMELINE_POST='https://timeline.line.me/post/'
readonly XPATH_INIT_DATA='//*[@id="init_data"]/text()'
readonly JQ_POSTS='.userHome.feeds[].post'
readonly JQ_POSTS_COMPACT=' | {post: (.postInfo.homeId + "/" + .postInfo.postId), text:.contents.text, title:.additionalContents.title}'

cat - \
  | xmllint --xpath "$XPATH_INIT_DATA" --html - 2>/dev/null \
  | {
    if "$OPTION_COMPACT_OUTPUT"; then
      cat - | jq -c "${JQ_POSTS}${JQ_POSTS_COMPACT}"
    else
      cat -
    fi  
  }
