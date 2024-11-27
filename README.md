Unpack Script

This script is a versatile tool for unpacking various types of compressed files and directories. It supports both single-file and directory-based operations and includes features like recursive processing and verbose logging. Below is a comprehensive guide on how to use it.

Features

Supported Compression Formats:

.zip

.bz2

.gz

.Z

Key Functionalities:

Automatically generates unique file or directory names if conflicts arise.

Recursively processes directories when specified.

Verbose mode for detailed output.

Error Handling:

Tracks failed decompression attempts.

Provides clear summary output at the end.

Usage

unpack [-r] [-v] file [file...]

Options

-r : Enables recursive processing of directories.

-v : Enables verbose mode for detailed output of operations.

Arguments

file : One or more files or directories to process.

Examples

Unpack a single file:

./unpack file.zip

Unpack all files in a directory (non-recursive):

./unpack /path/to/directory

Recursive unpacking:

./unpack -r /path/to/directory

Verbose mode for detailed logs:

./unpack -v file.gz

Combine options:

./unpack -r -v /path/to/directory

Script Logic

File Name Generation:

If a file or directory name already exists, a new name is generated using a numbered suffix (e.g., file(1).zip, dir(2)).

Unpacking Specific Formats:

.zip: Extracts files to a new directory.

.bz2: Decompresses into a new file.

.gz: Extracts to a directory with a unique name.

.Z: Decompresses into a new file.

Directory Processing:

Iterates through all items in a directory.

If recursive mode is enabled, processes subdirectories.

Summary Output:

Provides a count of successfully unpacked archives.

Reports the number of failed attempts.

Requirements

unzip: For handling .zip files.

bunzip2: For handling .bz2 files.

gunzip: For handling .gz files.

uncompress: For handling .Z files.

Make sure these utilities are installed on your system and accessible in your $PATH.

Error Handling

If an invalid file or directory is specified, the script will log an error and continue processing the next item.

Failed decompression attempts are reported in the summary output.

Exit Codes

0: Success - All files were decompressed successfully.

1: Failure - Some files could not be decompressed.

Contributing

Feel free to submit issues or pull requests on the GitHub repository to enhance the script. Contributions are always welcome!

License

This script is open-source and distributed under the MIT License. See the LICENSE file for details.

Author

Developed by [Naor Ladani].

