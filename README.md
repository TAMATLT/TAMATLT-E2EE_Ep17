# TAMAT LT E2EE Ep17 Robots Repository
This repository contains examples I have used in Ep17 of my E2E:E Series

**If you are an expert in OpenComputers and see that some of these scripts mirror default functions or could be done better**
**PLEASE let me know what could be changed in the Issues section**

If you do not know much about lua programming here is what you do:

- In any computer in opencomputers go into OpenOS and navigate to the #home directory
- In the command line type `edit <filenale.lua>`, where **<filename.lua>** is your script. This opens script editor.
- Minimize minecraft and switch to web brouser.
- Open the *.lua script you want in this repository and copy its contents.
- Go back to minecraft window, back to the editor and press middle mouse button, which will insert contents of .lua script into the editor
- Press 'Ctrl + S' to save file inside OpenOS.
- Press 'Ctrl + W' to close the editor and back to command line.
- Run the script by typing `<filename>` without .lua part if your script name was <filenale.lua>. The you might need to type any arguments for the script like this `<filename> arg1 arg2`
- Alternative route is to find out where your game files are stored in your system and manipulate these files outside of minecraft (see **check.lua** section below)

# Scripts in this repository

## Check.lua

Lets say you have made your 20th computer with OpenComputers mod, installed OpenOS, created a file there and now want to open this file with your editor outside of Minecraft.

You will have to sift through many folders until you find the ine you are looking for.

This helpful script **check.lua** will tell you which folder on your actual machine stores contents of OpenOS hard drive in Game.

When you run the script the output will show you several folders:

![checkExample](Img/CheckExample.png?raw=true "Example for Check.lua")

The one labeled OpenOS is the one you are looking for and it can be opened on your sistem in:
../instances/%instance name%/.mincraft/saves/opencomputers/

## runScript.lua

When I am writing the code for my OpenComputers setups I rely heavily on LLMs. And when my scripts fail I need to copy the error message out of Minecraft and paste it to LLM for debugging.

As far as I am aware by default you have to simply retype the code into the LLM, and this is not convinient.

This helpful script **runScript.lua** can be used to circumvent that. If the script that errors is called *script.lua* you should run:

`runScript.lua script.lua`

If any errors pop up in your **script.lua** they will be saved to a text file `error_log.txt` instead of being shown on the screen.

If your script has any arguments you can run the whole thing like this:

`runScript.lua script.lua arg1 arg2 arg3`

## customPrint.lua

Simple print3d command provided by OPPM works well for printing a single item. For everything else you got **customPrint.lua**.

Prerequisites: 

- Install OPPM package print3d from OPPM disk
- Connect the printer to the computer
- Have a transposer connected to the same computer
- Have an output inventory connected to the transposer
- Transposer **must** touch only 2 inventories: the printer and the output inventory

Once done, create a text file **models.txt**. It has to be in the same directory as **customPrint.lua**. 

Inside this file make as many entries as you want for each model. Each entry is a separate line and need to look exactly like this: `%Description%:modelFile.3dm`.

For example:
  `Double-Layer Capacitor:doubleLayerCapacitor.3dm`

Each model file (in the example above **doubleLayerCapacitor.3dm**) for every entry needs to be in the same folder as **customPrint.lua**.

Once all of the above is complete run `customPrint`.

The program will show a list of avialable models to print (from **models.txt**) and will expect an index of the item you like to print.

Next the program will ask how many items need printing. It again expects a number. For example:

![customPrintExample](Img/customPrintExample.png?raw=true "Example for Check.lua")

The script was not properly vetted for all of the cases where something goes wrong: printer runs out of materials, inventories are full, you type srong character etc.

Simply be a bit careful and you will be fine.





