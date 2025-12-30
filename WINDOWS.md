# Windows Distribution Guide

This guide explains how to create and distribute Windows executables of your Quickstrap-based application.

## Overview

While Quickstrap is designed for Linux development, you can easily create standalone Windows executables that work without requiring Python installation on the target system.

## For Developers (Building the EXE)

### Prerequisites

- Linux development environment with Quickstrap installed
- Your application working correctly with `./install.py` and `./start.sh`

### Build Process

1. **Install your application**:
   ```bash
   ./install.py
   ```

2. **Build the Windows EXE**:
   ```bash
   ./quickstrap/scripts/build_windows_exe.sh
   ```

3. **Find your EXE**:
   The executable will be in the `dist/` directory:
   ```bash
   ls -lh dist/*.exe
   ```

### Customizing the Build

For advanced configuration (icon, additional files, GUI mode), create a custom spec file:

```bash
# Copy the template
cp quickstrap/pyinstaller.spec.template quickstrap/pyinstaller.spec

# Edit the configuration
nano quickstrap/pyinstaller.spec
```

Key settings to customize:

```python
# Application name (name of the EXE)
APP_NAME = 'MyApp'

# Icon file (Windows .ico format)
ICON_FILE = 'app.ico'

# Include additional files/directories
DATAS = [
    ('config', 'config'),
    ('data', 'data'),
]

# Console window (False for GUI apps, True for CLI apps)
CONSOLE = False
```

After customizing, run the build script again.

## For End Users (Running the EXE)

### Simple Usage

1. Download the `.exe` file
2. Double-click to run
3. No Python installation required!

### Command Line Usage

If the application accepts command-line arguments:

```cmd
MyApp.exe --help
MyApp.exe --config production
```

### System Requirements

- Windows 10 or later (64-bit)
- No Python installation needed
- No additional dependencies (all bundled in the EXE)

## Cross-Platform Considerations

### Paths

If your application uses file paths, ensure they work on both Linux and Windows:

```python
from pathlib import Path

# Good: Works on both platforms
config_file = Path.home() / '.config' / 'myapp' / 'config.ini'

# Bad: Linux-specific
config_file = os.path.expanduser('~/.config/myapp/config.ini')
```

### Configuration Directory

On Windows, user config is typically stored in:
```
C:\Users\YourName\AppData\Roaming\myapp\
```

Consider using `pathlib` or `platformdirs` for cross-platform config paths:

```python
from pathlib import Path

def get_config_dir():
    if sys.platform == 'win32':
        config_dir = Path.home() / 'AppData' / 'Roaming' / 'myapp'
    else:
        config_dir = Path.home() / '.config' / 'myapp'

    config_dir.mkdir(parents=True, exist_ok=True)
    return config_dir
```

### Testing

To test your Windows EXE without a Windows machine:

1. Use Wine (Linux):
   ```bash
   wine dist/MyApp.exe
   ```

2. Use a Windows VM or Docker container

3. Ask a Windows user to test it

## Common Issues

### EXE is Too Large

**Problem**: Generated EXE is 50+ MB

**Solution**: Exclude unused modules in `pyinstaller.spec`:

```python
EXCLUDES = [
    'matplotlib',  # If you don't use plotting
    'numpy',       # If you don't use numerical computing
    'tkinter',     # If you don't use Tkinter GUI
]
```

### Missing Modules at Runtime

**Problem**: EXE crashes with "ModuleNotFoundError"

**Solution**: Add missing modules to `pyinstaller.spec`:

```python
HIDDEN_IMPORTS = [
    'package.submodule',
    'problematic_module',
]
```

### Runtime Errors with File Paths

**Problem**: Application can't find data files

**Solution**: Use PyInstaller's `sys._MEIPASS` for bundled files:

```python
import sys
from pathlib import Path

def get_resource_path(relative_path):
    """Get absolute path to resource, works for dev and for PyInstaller"""
    try:
        # PyInstaller creates a temp folder and stores path in _MEIPASS
        base_path = Path(sys._MEIPASS)
    except Exception:
        base_path = Path(__file__).parent

    return base_path / relative_path

# Usage
config_file = get_resource_path('config/default.ini')
```

### Antivirus False Positives

**Problem**: Windows Defender flags the EXE as malware

**Solution**: This is common with PyInstaller. Options:
1. Sign your EXE with a code signing certificate (costs money)
2. Add an exception in Windows Defender
3. Distribute the source code instead for security-conscious users

## Distribution

### Direct Distribution

Simply share the `.exe` file:
- Upload to GitHub Releases
- Share via cloud storage (Dropbox, Google Drive, etc.)
- Host on your website

### Installer (Optional)

For a more professional distribution, create an installer:
- **NSIS** (Nullsoft Scriptable Install System)
- **Inno Setup**
- **WiX Toolset**

These tools can create installers that:
- Install to Program Files
- Create Start Menu shortcuts
- Add desktop icons
- Register file associations

## Best Practices

1. **Version Your Builds**: Tag releases in git before building
   ```bash
   git tag v1.0.0
   git push origin v1.0.0
   ```

2. **Include a README**: Add a `README.txt` alongside the EXE explaining usage

3. **Test on Real Windows**: Always test on an actual Windows machine before distributing

4. **Provide System Requirements**: Document minimum Windows version and any dependencies

5. **Keep Source Available**: Even with EXE distribution, keep source code available for transparency

## Further Reading

- [PyInstaller Documentation](https://pyinstaller.org/)
- [Python on Windows](https://docs.python.org/3/using/windows.html)
- [Windows Application Development Best Practices](https://docs.microsoft.com/en-us/windows/apps/develop/)
