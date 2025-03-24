echo "compiling"

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]
then
	echo "Usage $0 <project_path> <emulator_path> <filename>"
	exit 1
fi

FILENAME="${3%.asm}"

if [[ "$3" != *.asm ]]
then
	if [ if "$FILENAME.asm" ]
	then
		echo "$FILENAME"
	else
		echo "Error: File '$FILENAME.asm' does not exist."
		exit 1
	fi
else
	echo	"File $FILENAME.asm has been found"
fi

FULLPATH="$(pwd)/$FILENAME.asm"
echo "Full path: $FULLPATH"

ROOTPATH="$2"
echo "Root path: $ROOTPATH"

EMULATEDPATH="${FULLPATH#"$ROOTPATH/"}"
EMULATEDPATH="${EMULATEDPATH%"/$FILENAME.asm"}"
echo "Emulated path: $EMULATEDPATH"

PROJECTPATH=$1
echo "Project path: $PROJECTPATH"
(cd $PROJECTPATH && dosbox-x -c "cd $EMULATEDPATH" -c "tasm $FILENAME" -c "tlink $FILENAME")
