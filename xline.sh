#!/bin/bash

readonly XPATH_INIT_DATA='//*[@id="init_data"]/text()'

cat - | xmllint --xpath "$XPATH_INIT_DATA" --html - 2>/dev/null
