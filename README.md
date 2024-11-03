# TAMATLT-E2EE_Ep17_Robots_Scripts
This repository contains examples I have used in Ep17 of my E2E:E Series

If you do not know much about lua programming here is what you do:

- In any computer in opencomputers go into OpenOS command line and type "edit <filenale.lua>", where <filenale.lua> is your script. This opens script editor.
- Minimize minecraft and switch to web brouser.
- Open the *.lua script you want in this repository and copy its contents.
- Go back to minecraft window, back to the editor and press middle mouse button, which will insert contents of .lua script into the editor
- Press 'Ctrl + S' to save file inside OpenOS.
- Press 'Ctrl + W' to close the editor and back to command line.
- Run the script by typing "<filename>" without .lua part if your script name was <filenale.lua>. The you might need to type any arguments for the script like this "<filename> arg1 arg2"

# Scripts in this repository

## Check.lua

Lets say you have made your 20th computer with OpenComputers mod, installed OpenOS, created a file there and now want to open this file with your editor outside of Minecraft.

You will have to sift through many folders until you find the ine you are looking for.

This helpful script *check.lua* will tell you which folder on your actual machine stores contents of OpenOS hard drive in Game.

When you run the script the output will show you several folders:

![Alt text](Img/CheckExample.png?raw=true "Example for Check.lua")

The one labeled OpenOS is the one you are looking for and it can be opened on your sistem in:
../instances/%instance name%/.mincraft/saves/opencomputers/


