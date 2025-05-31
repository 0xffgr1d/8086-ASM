#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

usage() {
	echo "Usage: $0 <project_path> <emulator_path> <filename>"
	exit 1
}

if [ "$#" -lt 3 ]; then
	usage
fi

PROJECT_PATH="$1"
EMULATOR_PATH="$2"
INPUT_FILE="$3"
shift
shift
shift
ARGUMENTS="$@"

if [ ! -d "$PROJECT_PATH" ]; then
	echo "Error: Project path '$PROJECT_PATH' does not exist or is not a directory."
	exit 1
fi

if [ ! -d "$EMULATOR_PATH" ]; then
	echo "Error: Emulator path '$EMULATOR_PATH' does not exist or is not a directory."
	exit 1
fi

if [[ "$INPUT_FILE" != *.asm ]]; then
	INPUT_FILE+=".asm"
fi

FILENAME="${INPUT_FILE%.asm}"

if [ ! -f "$INPUT_FILE" ]; then
	echo "Error: File '$INPUT_FILE' does not exist."
	exit 1
fi

FULL_PATH="$(realpath "$INPUT_FILE")"
ROOT_PATH="$(realpath "$EMULATOR_PATH")"
EMULATED_PATH="${FULL_PATH#"$ROOT_PATH/"}"
EMULATED_PATH="${EMULATED_PATH%"/$FILENAME.asm"}"

if ! command -v dosbox-x &>/dev/null; then
	echo "Error: dosbox-x is not installed. Please install it first. (https://dosbox-x.com)"
	exit 1
fi


echo "Compiling $INPUT_FILE..."
if [ -f "$PROJECT_PATH/ms-dos.img" ]; then
	sudo $PROJECT_PATH/ms-dos.sh $PROJECT_PATH $EMULATED_PATH $FILENAME $ARGUMENTS
else
	$PROJECT_PATH/dosbox-x.sh $PROJECT_PATH $EMULATED_PATH $FILENAME $ARGUMENTS
fi

echo "Compilation completed successfully."
