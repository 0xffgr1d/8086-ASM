# 8086-ASM
this is a project to learn 8086-ASM  
`Prog\ND*` are solutions to:  
https://klevas.mif.vu.lt/~julius/2011Rud/KompArch/Uzd1.html  
https://klevas.mif.vu.lt/~julius/2011Rud/KompArch/Uzd2.html  
https://klevas.mif.vu.lt/~julius/2011Rud/KompArch/Uzd3.html  
`Prog\TEST` is a folder for my own learning experience  

## Dependencies to run
[TASM](https://klevas.mif.vu.lt/~linas1/KompArch/Asembleris.tar.gz) (Idont know where the original file came from, but i downloaded it from here)  
TASM files should be put in a directory called 'Tasm' in the same directory as 'Prog' and 'dosbox-x.conf' are stored in  
[DOSBOX-X](https://dosbox-x.com/)  
[tmux](https://github.com/tmux/tmux/wiki)  
**optional:**  
[ms-dos](https://archive.org/download/MS_DOS_6.22_MICROSOFT/MS%20DOS%206.22.zip)  

## Tmux session
running `tmux_workspace.sh` will open two panel window  
first panel will automaticaly have vim open
second panel will have `compile` command aliased

## `compiler.sh` script and `compile` command
both `compiler.sh` and `compile` should be run in the directory containing the file  
compiler.sh takes in 3 arguments:  
1. project_path - directory where the project is located  
2. emulator_path - directory which will be mounted on the emulator  
3. file_name - name of the file to compile  


compile is aliased by running `source aliases` in the same directory as the file itself
compile only takes a single parameter:  
1. file_name - name of the file to compile  

if ms-dos is set up it will be preffered over plain dosbox-x, but will require root priveleges  

## ms-dos installation
extract disk images from downloaded archive to main directory and run ./install.sh  

