xline - eXtract data from LINE timeline

# Usage

```
% curl https://timeline.line.me/user/SOMEONE | xline.sh [-hxcu]
```

# Options

## `-c` Compact Output

1 post in 1 line.
```
% curl https://timeline.line.me/user/SOMEONE | xline.sh -c
{"post":"SOMEONE/1111111111111111111","text":"CONTENTS","blogTitle":"TITLE",blogUrl:"https://xxxx"}
{"post":"SOMEONE/2222222222222222222","text":"CONTENTS","blogTitle":null,blogUrl:null}
{"post":"SOMEONE/3333333333333333333","text":"CONTENTS","blogTitle":"TITLE",blogUrl:"https://xxxx"}
{"post":"SOMEONE/4444444444444444444","text":"CONTENTS","blogTitle":null,blogUrl:null}
...
```
- `post`: path of post page URL
- `text`: post content
- `blogTitle`: posted blog's title (`null` if not blog)
- `blogUrl`: posted blog's URL (`null` if not blog)

## `-u` URLs

Show post's URLs.
```
% curl https://timeline.line.me/user/SOMEONE | xline.sh -u
https://timeline.line.me/post/SOMEONE/1111111111111111111
https://timeline.line.me/post/SOMEONE/2222222222222222222
https://timeline.line.me/post/SOMEONE/3333333333333333333
https://timeline.line.me/post/SOMEONE/4444444444444444444
```

## `-x` Exclude blog posts


```
% curl https://timeline.line.me/user/SOMEONE | xline.sh -cx
{"post":"SOMEONE/2222222222222222222","text":"CONTENTS","blogTitle":null,"blogUrl":null}
{"post":"SOMEONE/4444444444444444444","text":"CONTENTS","blogTitle":null,"blogUrl":null}
```

```
% curl https://timeline.line.me/user/SOMEONE | xline.sh -ux
https://timeline.line.me/post/SOMEONE/2222222222222222222
https://timeline.line.me/post/SOMEONE/4444444444444444444
```
