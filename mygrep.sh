#!/bin/bash

print_help() {
  echo "Usage: $0 [options] search_string filename"
  echo "Options:"
  echo "  -n    Show line numbers"
  echo "  -v    Invert match (show non-matching lines)"
  echo "  --help Show this help message"
}

if [[ "$1" == "--help" ]]; then
  print_help
  exit 0
fi

if [[ $# -lt 2 ]]; then
  echo "Error: Not enough arguments."
  print_help
  exit 1
fi

show_line_number=false
invert_match=false

while [[ "$1" == -* ]]; do
  case "$1" in
    -n) show_line_number=true ;;
    -v) invert_match=true ;;
    --help) print_help; exit 0 ;;
    *) echo "Unknown option: $1"; print_help; exit 1 ;;
  esac
  shift
done

search_string="$1"
shift

file="$1"

if [[ -z "$search_string" || -z "$file" ]]; then
  echo "Error: Missing search string or filename."
  print_help
  exit 1
fi

if [[ ! -f "$file" ]]; then
  echo "Error: File '$file' not found."
  exit 1
fi

line_number=0
while IFS= read -r line; do
  ((line_number++))
  
  if echo "$line" | grep -iq "$search_string"; then
    match=true
  else
    match=false
  fi

  if $invert_match; then
    match=$(! $match)
  fi

  if $match; then
    if $show_line_number; then
      echo "${line_number}:$line"
    else
      echo "$line"
    fi
  fi
done < "$file"
