#!/usr/bin/env bash
echo "*vimfiles*  Vimfiles documentation"
echo ""
echo "=============================================================================="
echo "KEY BINDINGS                                                     *vimfiles-keys*"
echo ""
grep -h -E '^\"\"' plugin/*/*.vim plugin/*.vim \
  | sed 's/\[N\]/   /g' \
  | sort \
  | sed 's/: / -- /g' \
  | sed 's/^"" //g' \
  | awk -F ' -- ' '{printf "`%-24s` |%s|  %s\n", $1, $2, $3}'
echo ""
echo "vim:tw=78:ts=8:ft=help:norl:"