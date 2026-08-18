# iGrab 📱 ➡️ 💻

A fast, robust, and interactive Bash utility to copy/sync video files from a USB-connected Android phone to a macOS system.

## 🚀 Features

- **Interactive Mode**: Prompts you step-by-step for custom configurations when run without parameters.
- **Zero-Waste Incremental Sync**: Compares filenames and file sizes to copy only new or modified videos.
- **Dynamic Diagnostics**: Automatically searches for the `adb` binary, starts the server, and walks you through authorizing the connection on your device screen if needed.
- **Collision Prevention**: When using the `--flat` flag, file name collisions are automatically resolved by appending numerical suffixes (e.g. `video_1.mp4`) instead of overwriting existing files.
- **CLI Automation Support**: Includes full argument parsing for headless operation, dry runs, and cron jobs.
- **Post-Download Cleanup**: Optional, secure cleanup that can delete successfully transferred videos from the phone to reclaim space (safely prompts for confirmation).

---

## 🛠️ Prerequisites

Before running the tool, ensure you have:
1. **USB Debugging enabled** on your Android device:
   - Go to **Settings** > **About Phone** and tap **Build number** 7 times.
   - Go to **Developer Options** and toggle **USB Debugging** ON.
2. **Mac Connected to Phone**: Plug the device into your Mac via a USB cable.

---

## 📦 Installation

To install `iGrab` globally on your Mac so that it can be run from any directory:

1. Clone or download the repository.
2. Run the installer script:
   ```bash
   ./install.sh
   ```
   *(The installer creates a symbolic link in `/usr/local/bin`. If write permissions are needed, it will prompt you for `sudo`.)*

---

## 📖 Usage

### 1. Global Command (Recommended)
Once installed, execute it globally:
```bash
igrab
```

### 2. Local Execution
Run the local script directly:
```bash
./igrab
```

### 3. CLI Command Options

| Argument / Flag | Description |
| :--- | :--- |
| `-d, --dest <path>` | Set destination directory on macOS (defaults to `~/Movies/Android_Videos`). |
| `-s, --scan-mode <mode>` | Search scope on Android:<br>• `camera`: DCIM/Camera only *(default)*<br>• `common`: Camera, Movies, Download, Pictures<br>• `deep`: Entire internal storage (`/sdcard`) |
| `--flat` | Flattens the directory structure so all files are stored directly in the target root folder. |
| `--delete-after` | Delete successfully downloaded videos from the phone to free up space (requires confirmation). |
| `--dry-run` | Scans and lists files that would be downloaded/skipped without performing any transfers. |
| `-f, --force` | Bypasses safety prompts (useful for automated scripts). |
| `-h, --help` | Show options menu. |

### 💡 CLI Examples

- **Only scan and preview files to be synced**:
  ```bash
  igrab --dry-run
  ```
- **Sync all videos from common folders into a flattened custom directory**:
  ```bash
  igrab --dest ~/Desktop/SyncVideos --scan-mode common --flat
  ```
- **Perform a deep sync and automatically free up storage space on the phone**:
  ```bash
  igrab --scan-mode deep --delete-after --force
  ```