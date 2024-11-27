# Unpack Script

![Shell Script](https://img.shields.io/badge/shell-bash-blue)
![License](https://img.shields.io/badge/license-MIT-green)
![Contributions](https://img.shields.io/badge/contributions-welcome-brightgreen)

## Overview

The `unpack` script is a powerful Bash tool for unpacking compressed files and directories. With support for multiple formats, recursive directory unpacking, and verbose output, this script makes file extraction simple and efficient.

---

## Features

- **Supported Compression Formats:**
  - `.zip`, `.bz2`, `.gz`, `.Z`
- **Unique Name Handling:** Avoid overwriting by generating new names automatically.
- **Recursive Unpacking:** Process entire directories and subdirectories.
- **Verbose Logging:** See what’s happening during unpacking.
- **Error Reporting:** Know which files failed to unpack and why.

---

## Installation

Clone the repository:
```bash
git clone https://github.com/your-username/unpack-script.git
```
Navigate to the directory:
```bash
cd unpack-script
```
Make the script executable:
```bash
chmod +x unpack.sh
```

---

## Usage

Run the script using:
```bash
./unpack [-r] [-v] file [file...]
```

### Command Options

- `-r` : Recursive mode (process subdirectories).
- `-v` : Verbose mode (detailed logging).

### Examples

1. **Unpack a single file:**
   ```bash
   ./unpack file.zip
   ```

2. **Recursive unpacking:**
   ```bash
   ./unpack -r /path/to/directory
   ```

3. **Verbose mode:**
   ```bash
   ./unpack -v file.gz
   ```

4. **Combine options:**
   ```bash
   ./unpack -r -v /path/to/directory
   ```

---

## Requirements

Ensure the following utilities are installed:

- `unzip`
- `bunzip2`
- `gunzip`
- `uncompress`

---

## Contributing

Contributions are welcome! Follow these steps:

1. Fork the repository.
2. Create a new branch for your feature or bugfix:
   ```bash
   git checkout -b feature-name
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add feature"
   ```
4. Push to your branch:
   ```bash
   git push origin feature-name
   ```
5. Open a pull request.

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## Contact

For any issues or questions, please open an issue or contact [Your Name](mailto:your-email@example.com).

---

### Show Your Support

If you find this script helpful, please give the repository a ⭐ on GitHub!

![GitHub Stars](https://img.shields.io/github/stars/your-username/unpack-script?style=social)
