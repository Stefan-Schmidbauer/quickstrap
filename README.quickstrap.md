# Quickstrap

**A lightweight, profile-based installation framework for Python projects**

Quickstrap provides a simple, reusable installation system that handles both Python packages (pip) and system packages (apt/dpkg), with support for multiple installation profiles and post-install hooks.

## Features

- **Profile-Based Installation** - Define multiple installation profiles (e.g. minimal, standard, full, development)
- **Hybrid Package Management** - Manages both system packages (apt) and Python packages (pip)
- **Virtual Environment** - Automatic venv creation and management
- **Feature Detection** - Applications can detect which features were installed
- **Post-Install Hooks** - Run custom scripts after installation
- **Template-Driven** - No code changes needed, just configure INI files
- **Copy-and-Go** - Clone, configure, and you're ready to deploy

## Quick Start

### For New Projects

1. **Clone Quickstrap into your project:**

   ```bash
   git clone https://github.com/Stefan-Schmidbauer/quickstrap.git my-project
   cd my-project
   ```

2. **Configure your application:**
   Edit `quickstrap/installation_profiles.ini`:

   - Set your app name, config directory, and start command
   - Define your features
   - Uncomment and customize profiles as needed

3. **Add your dependencies:**

   - Edit `quickstrap/requirements_python.txt` - add your Python packages
   - Edit `quickstrap/requirements_system.txt` - add your system packages

4. **Add your application code:**

   ```bash
      # Create your Python application
   ```

5. **Install and run:**
   ```bash
   ./install.py
   ./start.sh
   ```

### For Existing Projects

1. **Add Quickstrap to your project:**

   ```bash
   cd your-existing-project
   git clone https://github.com/Stefan-Schmidbauer/quickstrap.git quickstrap-temp
   cp quickstrap-temp/install.py .
   cp quickstrap-temp/start.sh .
   cp -r quickstrap-temp/quickstrap .
   rm -rf quickstrap-temp
   ```

2. **Configure and install:**
   - Edit `quickstrap/installation_profiles.ini`
   - Add dependencies to `quickstrap/requirements_*.txt`
   - Run `./install.py`

## Installation Profiles

Profiles allow you to define different installation scenarios:

```ini
[profile:minimal]
name = Minimal Installation
description = CLI-only installation
features = cli
python_requirements = quickstrap/requirements_python.txt
system_requirements = quickstrap/requirements_system.txt

[profile:full]
name = Full Installation
description = Complete installation with all features
features = gui,pdf,database,printing,api
python_requirements = quickstrap/requirements_python_full.txt
system_requirements = quickstrap/requirements_system_full.txt
post_install_scripts = quickstrap/scripts/init_database.sh
```

## Feature Detection

Your application can detect which features were installed by reading the configuration file created by Quickstrap:

```python
from pathlib import Path
from configparser import ConfigParser

def get_installed_features(config_dir_name: str) -> set:
    """Read installed features from Quickstrap config."""
    config_file = Path.home() / '.config' / config_dir_name / 'installation_profile.ini'

    if not config_file.exists():
        return set()

    config = ConfigParser()
    config.read(config_file)

    features_str = config.get('installation', 'features', fallback='')
    return set(f.strip() for f in features_str.split(',') if f.strip())

# Usage:
features = get_installed_features('my-app')

if 'gui' in features:
    import tkinter
    # Enable GUI features

if 'pdf' in features:
    from reportlab.pdfgen import canvas
    # Enable PDF generation
```

The configuration is stored at: `~/.config/{your-config-dir}/installation_profile.ini`

## Post-Install Scripts

Add custom setup scripts that run after package installation:

```ini
[profile:standard]
...
post_install_scripts = quickstrap/scripts/init_database.sh,quickstrap/scripts/check_deps.sh
```

Quickstrap includes template scripts in `quickstrap/scripts/`:

- `check_file_exists.sh` - Verify required files exist
- `init_sqlite_database.sh` - Initialize SQLite database
- `check_cups_printing.sh` - Verify CUPS printing system
- `setup_config_directory.sh` - Create config directories

Simply uncomment and customize these templates for your needs. Then configure post_install_scripts to start the script.

If the script fails, the installation fails.

### Environment Variables Available to Scripts

Post-install scripts have access to these environment variables:

- `QUICKSTRAP_APP_NAME` - The application name from metadata
- `QUICKSTRAP_CONFIG_DIR` - The config directory name from metadata
- `VIRTUAL_ENV` - Path to the virtual environment (e.g., `/path/to/project/venv`)
- `PATH` - Automatically updated to include the venv's `bin` directory first. This ensures that when your script calls `python`, `pip`, or any installed Python tools, the versions from the virtual environment are used instead of system versions. You can directly use commands like `python script.py` without specifying the full venv path.

Example usage in a script:

```bash
#!/bin/bash
echo "Setting up $QUICKSTRAP_APP_NAME..."
CONFIG_PATH="$HOME/.config/$QUICKSTRAP_CONFIG_DIR"
mkdir -p "$CONFIG_PATH"
```

## Usage

### Interactive Installation

```bash
./install.py
```

Presents a menu to choose from available profiles.

### Direct Profile Installation

```bash
./install.py --profile standard
```

Installs the specified profile directly.

### Rebuild Virtual Environment

```bash
./install.py --profile standard --rebuild-venv
```

Recreates the virtual environment from scratch.

### Dry Run

```bash
./install.py --dry-run
```

Shows what would be installed without making changes.

### Start Application

```bash
./start.sh
```

Activates the virtual environment and starts your application.

## Configuration Reference

### Metadata Section (`[metadata]`)

Global application configuration:

| Field           | Required | Description                                                     |
| --------------- | -------- | --------------------------------------------------------------- |
| `app_name`      | Yes      | Display name of your application                                |
| `config_dir`    | Yes      | Directory name under `~/.config/` for storing installation info |
| `start_command` | Yes      | Command to start your application (e.g., `python3 src/main.py`) |
| `after_install` | No       | Message displayed after successful installation                 |

### Profile Section (`[profile:NAME]`)

Installation profile configuration:

| Field                  | Required | Description                                                               |
| ---------------------- | -------- | ------------------------------------------------------------------------- |
| `name`                 | Yes      | Display name of the profile                                               |
| `description`          | Yes      | Description of what this profile includes                                 |
| `features`             | Yes      | Comma-separated feature list (used by your app for feature detection)     |
| `python_requirements`  | Yes      | Path to Python packages file (e.g., `quickstrap/requirements_python.txt`) |
| `system_requirements`  | Yes      | Path to system packages file (e.g., `quickstrap/requirements_system.txt`) |
| `post_install_scripts` | No       | Comma-separated list of post-install scripts to run                       |

### Example Configuration

```ini
[metadata]
app_name = My Amazing App
config_dir = my-amazing-app
start_command = python3 src/main.py
after_install = Start with: ./start.sh

[profile:standard]
name = Standard Installation
description = Complete installation with all features
features = gui,pdf,database,printing
python_requirements = quickstrap/requirements_python.txt
system_requirements = quickstrap/requirements_system.txt
post_install_scripts = quickstrap/scripts/init_database.sh
```

## Requirements

**Before using Quickstrap, install these system packages:**

On Debian/Ubuntu:

```bash
sudo apt install python3 python3-pip python3-venv
```

Required:

- Python 3.6 or higher
- pip (Python package installer)
- venv (Virtual environment support)
- dpkg (Debian package manager - for system package verification)

**Note:** Quickstrap currently supports Debian/Ubuntu-based systems. The system package checking uses `dpkg` for package verification.

## Project Structure

```
your-project/
├── README.md                          # Your project documentation
├── README.quickstrap.md               # Quickstrap documentation (this file)
├── install.py                         # Quickstrap installer (stays in root)
├── start.sh                           # Quickstrap starter (stays in root)
├── quickstrap/                        # Quickstrap configuration directory
│   ├── installation_profiles.ini      # Your profiles configuration
│   ├── requirements_python.txt        # Your Python dependencies
│   ├── requirements_system.txt        # Your system dependencies
│   └── scripts/                       # Post-install scripts (templates)
│       ├── check_file_exists.sh
│       ├── init_sqlite_database.sh
│       ├── check_cups_printing.sh
│       └── setup_config_directory.sh
├── src/                               # Your application code
│   └── main.py
└── venv/                              # Virtual environment (created by install.py)
```

**Note:** Quickstrap keeps only 3 items in your project root: `install.py`, `start.sh`, and `README.quickstrap.md`. All other files are in the `quickstrap/` subdirectory to minimize conflicts with your project.

## Why Quickstrap?

Most Python projects use pip and requirements.txt, but many applications also need:

- System dependencies (GUI libraries, printing systems, databases)
- Different deployment scenarios (minimal vs full installation)
- Post-install initialization (database setup, config files)
- Feature detection (conditional imports based on what's installed)

Quickstrap provides all of this in a simple, reusable framework that requires no code changes - just configuration.

## License

MIT License - see [LICENSE](quickstrap/LICENSE) file for details.

Copyright (c) 2025 Stefan Schmidbauer

## Contributing

Contributions are welcome! Feel free to open issues or submit pull requests to improve Quickstrap.
