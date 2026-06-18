#!/usr/bin/env bash
set -u

find_starfield_window() {
  local id name

  while read -r id; do
    name="$(xdotool getwindowname "$id" 2>/dev/null || true)"

    if [[ "$name" == "Starfield" ]]; then
      echo "$id"
      return 0
    fi
  done < <(xdotool search --name Starfield 2>/dev/null || true)

  return 1
}

start_ns=$(date +%s%N)

steam "steam://rungameid/1716740" >/dev/null 2>&1 &

echo "Waiting for exact Starfield window..."

while true; do
  win_id="$(find_starfield_window || true)"

  if [[ -n "$win_id" ]]; then
    break
  fi

  sleep 0.05
done

end_ns=$(date +%s%N)
elapsed_ms=$(( (end_ns - start_ns) / 1000000 ))

printf 'Starfield exact window appeared after: %d.%03d seconds\n' \
  "$((elapsed_ms / 1000))" \
  "$((elapsed_ms % 1000))"