Using Virtualbox


### Share 1: Starfield game folder

- Folder path: `/mnt/extradrive1/SteamLibrary/steamapps/common/Starfield`
- Folder name: `starfield_game`
- `S:`
- Auto-mount: enabled
- Make Permanent: enabled
- Read-only: disabled

### Share 2: Proton documents folder

- Folder path: `/mnt/extradrive1/SteamLibrary/steamapps/compatdata/1716740/pfx/drive_c/users/steamuser/Documents/My Games/Starfield`
- Folder name: `starfield_docs`
- `Y:`
- Auto-mount: enabled
- Make Permanent: enabled
- Read-only: enabled

### Share 3: Proton local appdata folder

- Folder path: `/mnt/extradrive1/SteamLibrary/steamapps/compatdata/1716740/pfx/drive_c/users/steamuser/AppData/Local/Starfield`
- Folder name: `starfield_local`
- `L:`
- Auto-mount: enabled
- Make Permanent: enabled
- Read-only: enabled

### Copy from the shared drives into the Windows profile

Copy these files:

From `S:`:

- `S:\Starfield.ini` -> `C:\Users\<YourWindowsUser>\Documents\My Games\Starfield\Starfield.ini`

From `Y:`:

- `Y:\StarfieldCustom.ini` -> `C:\Users\<YourWindowsUser>\Documents\My Games\Starfield\StarfieldCustom.ini`
- `Y:\StarfieldPrefs.ini` -> `C:\Users\<YourWindowsUser>\Documents\My Games\Starfield\StarfieldPrefs.ini`

From `L:`:

- `L:\Plugins.txt` -> `C:\Users\<YourWindowsUser>\AppData\Local\Starfield\Plugins.txt`

Optional files to copy as well:

- `L:\ContentCatalog.txt`
- `Y:\ControlMap_Custom.txt`

If you prefer a command line copy in Windows, use:

```bat
copy S:\Starfield.ini "%USERPROFILE%\Documents\My Games\Starfield\Starfield.ini"
copy Y:\StarfieldCustom.ini "%USERPROFILE%\Documents\My Games\Starfield\StarfieldCustom.ini"
copy Y:\StarfieldPrefs.ini "%USERPROFILE%\Documents\My Games\Starfield\StarfieldPrefs.ini"
copy L:\Plugins.txt "%LOCALAPPDATA%\Starfield\Plugins.txt"
```