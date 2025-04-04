# Hosts File Manager

A batch script to manage the Windows `hosts` file with ease. This script provides a menu-driven interface to perform common tasks such as adding, searching, replacing, removing entries, backing up, and resetting the `hosts` file.

## Features

- **Add Entry**: Add a new IP address and URL mapping to the `hosts` file.
- **Search Entry**: Search for a specific URL in the `hosts` file.
- **Search and Replace Entry**: Replace an existing URL and IP address mapping with a new one.
- **Search and Remove Entry**: Remove a specific URL and its mapping from the `hosts` file.
- **Backup Hosts File**: Create a backup of the current `hosts` file with a timestamp.
- **Reset Hosts File**: Reset the `hosts` file to its default state.

## Requirements

- Windows operating system.
- Administrative privileges to modify the `hosts` file.

## Usage

1. Run the script as an administrator.
2. Select an option from the menu by entering the corresponding number.
3. Follow the prompts to complete the desired operation.

### Example Menu

```
Hosts File Manager
------------------
1. Add Entry
2. Search Entry
3. Search and Replace Entry
4. Search and Remove Entry
5. Backup Hosts File
6. Reset Hosts File
7. Exit

Enter your choice:
```

## Notes

- The script automatically requests administrative privileges if not already running as an administrator.
- Backups are saved to the desktop with a timestamp in the filename.
- Resetting the `hosts` file will overwrite all custom entries with the default content.

## Disclaimer

Use this script with caution. Modifying the `hosts` file can affect network behavior and access to websites. Always back up your `hosts` file before making changes.
