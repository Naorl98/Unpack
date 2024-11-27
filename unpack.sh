#!/bin/bash

# Function to generate a new file name if it already exists
generate_new_file_name() {
    local file_path="$1"
    local base_name="${file_path%.*}"
    local extension="${file_path##*.}"
    local new_file="$file_path"
    local count=1

    while [[ -e "$new_file" ]]; do
        new_file="${base_name}(${count})"
        count=$((count + 1))
    done

    echo "$new_file"
}

# Function to generate a new directory name if it already exists
generate_new_dir_name() {
    local dir_path="$1"
    local base_name="$(basename "$dir_path" .zip)"
    local new_dir="$dir_path"
    local count=1

    while [[ -e "$new_dir" ]]; do
        new_dir="${dir_path%/*}/$base_name($count)"
        count=$((count + 1))
    done

    echo "$new_dir"
}

# Function to unpack a single file
unpack_file() {
    local file="$1"
    local target_dir="$(dirname "$file")"

    case "$(file -b --mime-type "$file")" in
        application/zip)
            local output_dir="$(generate_new_dir_name "$target_dir/$(basename "$file" .zip)")"
            mkdir -p "$output_dir"
            unzip -o "$file" -d "$output_dir" && return 0 ;;
        application/x-bzip2)
            local new_file="$(generate_new_file_name "$target_dir/$(basename "$file" .bz2)")"
            bunzip2 -k "$file" && mv "${file%.bz2}" "$new_file" && return 0 ;;
        application/gzip)
            local output_dir="$(generate_new_dir_name "$target_dir/$(basename "$file" .gz)")"
            mkdir -p "$output_dir"
            local new_file="$(generate_new_file_name "$output_dir/$(basename "$file" .gz)")"
            gunzip -c "$file" > "$new_file" && return 0 ;;
        application/x-compress)
            local new_file="$(generate_new_file_name "$target_dir/$(basename "$file" .Z)")"
            uncompress -c "$file" > "$new_file" && return 0 ;;
        *)
            return 1 ;;
    esac
}

# Function to unpack files in a directory
unpack_directory() {
    local dir="$1"
    local count=0
    local failed=0

    for item in "$dir"/*; do
        if [[ -d "$item" && $RECURSIVE -eq 1 ]]; then
            unpack_directory "$item"
        elif [[ -f "$item" ]]; then
            if unpack_file "$item"; then
                count=$((count + 1))
                [[ $VERBOSE -eq 1 ]] && echo "Unpacking $item..."
            else
                failed=$((failed + 1))
                [[ $VERBOSE -eq 1 ]] && echo "Ignoring $item"
            fi
        fi
    done

    echo "$count"
    return "$failed"
}

# Main script logic
VERBOSE=0
RECURSIVE=0

# Parse command-line options
while getopts ":vr" opt; do
    case $opt in
        v) VERBOSE=1 ;;
        r) RECURSIVE=1 ;;
        *) echo "Usage: unpack [-r] [-v] file [file...]" >&2; exit 1 ;;
    esac
done
shift $((OPTIND - 1))

# Check if any files were provided
if [ $# -eq 0 ]; then
    echo "Usage: unpack [-r] [-v] file [file...]" >&2
    exit 1
fi

total_count=0
total_failed=0

# Process each provided file or directory
for target in "$@"; do
    if [[ -d "$target" ]]; then
        if [ $RECURSIVE -eq 1 ]; then
            count=$(unpack_directory "$target")
            total_count=$((total_count + count))
            failed=$?
            total_failed=$((total_failed + failed))
        else
            echo "$target is a directory. Use -r for recursive unpacking." >&2
        fi
    elif [[ -f "$target" ]]; then
        if unpack_file "$target"; then
            total_count=$((total_count + 1))
            [[ $VERBOSE -eq 1 ]] && echo "Unpacking $target..."
        else
            total_failed=$((total_failed + 1))
            [[ $VERBOSE -eq 1 ]] && echo "Ignoring $target"
        fi
    else
        echo "$target is not a valid file or directory." >&2
        total_failed=$((total_failed + 1))
    fi
done

# Summary output
echo "Decompressed $total_count archive(s)"
if [ $total_failed -gt 0 ]; then
    echo "What happened? Command returned $total_failed (failure for $total_failed file(s))"
    exit 1
else
    echo "What happened? Command returned 0 (success)"
    exit 0
fi

