# Removing an old "MrMark" installation

MarkPad was previously distributed under the name **MrMark**. The two are
separate apps as far as your OS is concerned — nothing carries over, and the
old one leaves behind a few files and settings. This is the only document
that mentions the old name; follow the steps for your OS to remove them.

File associations need no cleanup: once you set MarkPad as the default app
for `.md` files, the old registration is simply superseded.

## macOS

1. Quit MrMark if it's running, then delete the app:

   ```sh
   rm -rf /Applications/MrMark.app
   ```

2. Remove its preferences (window placement, "asked about defaults" flags,
   recent-files metadata) and saved window state:

   ```sh
   defaults delete com.jongsic.MrMark 2>/dev/null
   rm -f ~/Library/Preferences/com.jongsic.MrMark.plist
   rm -rf ~/Library/Saved\ Application\ State/com.jongsic.MrMark.savedState
   ```

## Windows

1. **If you used the installer**, uninstall it — the uninstaller removes the
   install folder, the Start Menu shortcut, and everything it registered:

   **Settings ▸ Apps ▸ Installed apps ▸ MrMark ▸ Uninstall**

2. **If you used the portable `MrMark.exe`** (or want to be thorough), delete
   the leftover per-user settings (recent files, window placement, the
   "make default?" prompt flag):

   ```bat
   reg delete "HKCU\Software\MrMark" /f
   ```

3. Delete the install folder and the benchmark log, if present:

   ```bat
   rmdir /s /q "%LOCALAPPDATA%\Programs\MrMark"
   del "%TEMP%\MrMark-benchmark.log"
   ```
