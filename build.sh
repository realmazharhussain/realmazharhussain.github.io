#!/usr/bin/env bash

output_dir=./public


help=no
while [[ $# != 0 ]]; do
  case "$1" in
    -h|--help) help=yes; break ;;
    --) shift; break ;; 
    -*) echo "Unknown argument '$arg', use -h or --help for help" >&2; exit 1 ;;
    *) break ;;
  esac
  shift
done

if [[ $help == yes ]]; then
  normal=$'\033[0m'
  bold=$'\033[1m'

  echo "Usage:"
  echo "  $0 [OPTION…] [--] [OUTPUT_DIR]"
  echo ""
  echo "Options:"
  echo "  -h,--help"$'\t'"Show this help message"
  echo ""
  echo "${bold}NOTE${normal}: If OUTPUT_DIR is not provided, '$output_dir' will be used by default"
  exit 0
fi

if [[ $# == 1 ]]; then
  output_dir=$1
elif [[ $# -gt 1 ]]; then
  echo "Too many arguments, use -h or --help for help" >&2
  exit 1
fi

if ! which sass &>/dev/null; then
  echo "sass not found! This site requires sass to be built" >&2
  exit 1
fi

echo "Compiling to '$output_dir'"

project_root=$(dirname "$(realpath "$0")")
output_dir=$(realpath "$output_dir")

rm -rf "$output_dir"
mkdir -p "$output_dir"

cp -t "$output_dir" "$project_root"/index.html
cp -t "$output_dir" -r "$project_root"/assets
cp -t "$output_dir" -r "$project_root"/donate
cp -t "$output_dir" -r "$project_root"/gdm-settings
sass "$project_root"/styles:"$output_dir"/styles

echo "Success!"
