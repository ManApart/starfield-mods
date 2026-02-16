#!/usr/bin/env bash
set -euo pipefail

APPID="1716740"
STEAM_LIBRARY="/mnt/extradrive1/SteamLibrary"
GAME="$STEAM_LIBRARY/steamapps/common/Starfield"

PROTON_BIN="$HOME/.steam/steam/steamapps/common/Proton - Experimental/proton"
COMPAT="$STEAM_LIBRARY/steamapps/compatdata/$APPID"

PAPYRUS_COMPILER="$GAME/Tools/Papyrus Compiler/PapyrusCompiler.exe"
FLAGS="$GAME/Data/scripts/source/Starfield_Papyrus_Flags.flg"
IMPORT_DIR="$GAME/Data/scripts/source"
OUT_DIR="$GAME/Data/scripts"

PSC_LINUX="$(realpath "${1:?Usage: $0 /path/to/script.psc}")"

to_z() { echo "Z:${1//\//\\}"; }

export STEAM_COMPAT_CLIENT_INSTALL_PATH="$HOME/.steam/steam"
export STEAM_COMPAT_DATA_PATH="$COMPAT"
export STEAM_DISABLE_VR=1
export WINEDEBUG=-all
export DXVK_LOG_LEVEL=none
export VKD3D_DEBUG=none

# Expected output .pex (best-effort: matches filename)
PSC_BASENAME="$(basename "$PSC_LINUX")"
PEX_NAME="${PSC_BASENAME%.psc}.pex"
PEX_PATH="$OUT_DIR/$PEX_NAME"
PEX_MTIME_BEFORE=0
[[ -f "$PEX_PATH" ]] && PEX_MTIME_BEFORE="$(stat -c %Y "$PEX_PATH")"

# Windows paths
COMPILER_WIN="$(to_z "$PAPYRUS_COMPILER")"
PSC_WIN="$(to_z "$PSC_LINUX")"
FLAGS_WIN="$(to_z "$FLAGS")"
IMPORT_WIN="$(to_z "$IMPORT_DIR")"
OUT_WIN="$(to_z "$OUT_DIR")"

# Logs via Windows redirection (stdout isn't reliable under Proton)
WINLOG='Z:\tmp\papyrus_out.txt'
LINUXLOG='/tmp/papyrus_out.txt'
CMDFILE_LINUX='/tmp/papyrus_run.cmd'
CMDFILE_WIN='Z:\tmp\papyrus_run.cmd'

rm -f "$LINUXLOG" "$CMDFILE_LINUX"

# Generate a .cmd with CRLF endings so cmd.exe parses it correctly
printf '@echo off\r\n"%s" "%s" -f="%s" -i="%s" -o="%s" > "%s" 2>&1\r\nexit /b %%errorlevel%%\r\n' \
  "$COMPILER_WIN" "$PSC_WIN" "$FLAGS_WIN" "$IMPORT_WIN" "$OUT_WIN" "$WINLOG" \
  > "$CMDFILE_LINUX"

set +e
"$PROTON_BIN" run cmd.exe /d /c "$CMDFILE_WIN" >/dev/null 2>&1
PROTON_STATUS=$?
set -e

# If no .pex updated, show compiler output (if any) and fail.
PEX_MTIME_AFTER=0
[[ -f "$PEX_PATH" ]] && PEX_MTIME_AFTER="$(stat -c %Y "$PEX_PATH")"

if [[ ! -f "$PEX_PATH" || "$PEX_MTIME_AFTER" -le "$PEX_MTIME_BEFORE" ]]; then
  [[ -f "$LINUXLOG" ]] && cat "$LINUXLOG" >&2
  exit 1
fi

# If Proton signaled failure but .pex updated, still surface the exit code.
if [[ "$PROTON_STATUS" -ne 0 ]]; then
  [[ -f "$LINUXLOG" ]] && cat "$LINUXLOG" >&2
  exit "$PROTON_STATUS"
fi

exit 0
