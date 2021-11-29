self: with self; ''
IFS=':' read -r -a INPUT <<< "$1"
FILE=''${INPUT[0]}
CENTER=''${INPUT[1]}

if [[ "$1" =~ ^[A-Za-z]:\\ ]]; then
  FILE=$FILE:''${INPUT[1]}
  CENTER=''${INPUT[2]}
fi

if [[ -n "$CENTER" && ! "$CENTER" =~ ^[0-9] ]]; then
  exit 1
fi
CENTER=''${CENTER/[^0-9]*/}

FILE="''${FILE/#\~\//$HOME/}"
if [ ! -r "$FILE" ]; then
  echo "File not found ''${FILE}"
  exit 1
fi

if [ -z "$CENTER" ]; then
  CENTER=0
fi

exec cat "$FILE" \
  | sed -e '/[#|\/\/ ?]-- copyright/,/[#\/\/]++/c\\' \
  | ${pkgs.coreutils}/bin/tr -s '\n' \
  | ${pkgs.bat}/bin/bat \
  --style="''${BAT_STYLE:-numbers}" \
  --color=always \
  --pager=never \
  --file-name=''$FILE \
  --highlight-line=$CENTER
''
