xline - eXtract data from LINE timeline

# Usage

```
% curl https://timeline.line.me/user/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx | xline.sh
```

# Options

## `-c` Compact Output

1 post in 1 line.
```
% curl https://timeline.line.me/user/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx | xline.sh -c
{"post":"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/1111111111111111111","text":"CONTENTS","title":"TITLE"}
{"post":"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/2222222222222222222","text":"CONTENTS","title":null}
{"post":"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/3333333333333333333","text":"CONTENTS","title":"TITLE"}
...
```
- `post`: path of post page ()
- `text`: post content
- `title`: posted blog's title (`null` if not blog)
