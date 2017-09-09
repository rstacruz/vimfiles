#!/usr/bin/env bash
echo "*vimfiles*  Vimfiles documentation"
echo ""
echo "=============================================================================="
echo "KEY BINDINGS                                                     *vimfiles-keys*"
echo ""
grep -h -E '^\"\"' plugin/*/*.vim plugin/*.vim \
  | sort \
  | sed 's/--/\t/g' \
  | sed 's/\[N\]/   /g' \
  | sed 's/^""/    /g' \
  | awk -F '\t' '{printf "%-30s %s\n", $1, $2}'
echo ""
echo "vim:tw=78:ts=8:ft=help:norl:"
