#!/bin/bash

# options
OPTION_COMPACT_OUTPUT=false
OPTION_URLONLY_OUTPUT=false
OPTION_EXCLUDE_BLOG=false
while getopts cux opts
do
  case $opts in
  c)  
    OPTION_COMPACT_OUTPUT=true
  ;;  
  u)  
    OPTION_COMPACT_OUTPUT=true
    OPTION_URLONLY_OUTPUT=true
  ;;  
  x)  
    OPTION_EXCLUDE_BLOG=true
  ;;  
  \?) 
    exit 1
  esac
done
shift $((OPTIND - 1))

readonly TIMELINE_POST='https://timeline.line.me/post/'
readonly XPATH_INIT_DATA='//*[@id="init_data"]/text()'
readonly JQ_POSTS='.userHome.feeds[].post'
readonly JQ_POSTS_EXCLUDE_BLOG=' | select(.additionalContents ==null)'
readonly JQ_POSTS_COMPACT=' | {post: (.postInfo.homeId + "/" + .postInfo.postId), text:.contents.text, blogTitle:.additionalContents.title, blogUrl:.additionalContents.url.targetUrl}'

cat - \
  | xmllint --xpath "$XPATH_INIT_DATA" --html - 2>/dev/null \
  | {
    if [[ $OPTION_COMPACT_OUTPUT || $OPTION_EXCLUDE_BLOG ]]; then
      arg="${JQ_POSTS}"
  
      if "$OPTION_EXCLUDE_BLOG"; then
        arg="${arg}${JQ_POSTS_EXCLUDE_BLOG}"
      fi

      if "$OPTION_COMPACT_OUTPUT"; then
        arg="${arg}${JQ_POSTS_COMPACT}"
      fi

      cat - | jq -c "$arg"
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
