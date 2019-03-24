#!/bin/bash

# options
OPTION_COMPACT_OUTPUT=false
OPTION_URLONLY_OUTPUT=false
while getopts cu opts
do
  case $opts in
  c)  
    OPTION_COMPACT_OUTPUT=true
  ;;  
  u)  
    OPTION_COMPACT_OUTPUT=true
    OPTION_URLONLY_OUTPUT=true
  ;;  
  \?) 
    exit 1
  esac
done
shift $((OPTIND - 1))

readonly TIMELINE_POST='https://timeline.line.me/post/'
readonly XPATH_INIT_DATA='//*[@id="init_data"]/text()'
readonly JQ_POSTS='.userHome.feeds[].post'
readonly JQ_POSTS_COMPACT=' | {post: (.postInfo.homeId + "/" + .postInfo.postId), text:.contents.text, blogTitle:.additionalContents.title, blogUrl:.additionalContents.url.targetUrl}'

cat - \
  | xmllint --xpath "$XPATH_INIT_DATA" --html - 2>/dev/null \
  | {
    if "$OPTION_COMPACT_OUTPUT"; then
      cat - | jq -c "${JQ_POSTS}${JQ_POSTS_COMPACT}"
    else
      cat -
    fi  
  } \
  | {
    if "$OPTION_URLONLY_OUTPUT"; then
      cat - | grep -oP '(?<="post":")[^"]+' | xargs -I{} echo "$TIMELINE_POST"{}
    else
      cat -
    fi
  }
