-- customPrint.lua
-- Script to print 3D models and transfer printed items to a connected chest using OpenComputers' oppm and print3d.

local component = require("component")
local filesystem = require("filesystem")
local printer = component.printer3d
local transposer = component.transposer

local modelsFile = "models.txt"  -- Text file mapping model names to file paths

-- example entry for models.txt: "Double-Layer Capacitor:doubleLayerCapacitor.3dm"


-- Function to load models from "models.txt"
function loadModels(filename)
    local models = {}
    local file = io.open(filename, "r")
    
    if not file then
        print("Error: Could not open " .. filename)
        return models
    end
    
    for line in file:lines() do
        local description, modelFile = line:match("(.+):(.+)")
        if description and modelFile then
            table.insert(models, {name = description, file = modelFile})
        end
    end
    
    file:close()
    return models
end

-- Function to check if a file exists
function fileExists(filename)
    return filesystem.exists(filename)
end

-- Function to wait for the printer to become idle
function waitForPrinter()
    while printer.status() == "busy" do
        os.sleep(1)  -- Wait for a second before checking again
    end
end

-- Function to detect and validate inventory setup on the transposer's sides
function detectInventories()
    local sourceSide = nil
    local destinationSide = nil

    for side = 0, 5 do
        local size = transposer.getInventorySize(side) or 0
        local inventoryName = transposer.getInventoryName(side) or "None"

        if size > 0 then
            if inventoryName:find("printer") then
                sourceSide = side
            else
                destinationSide = side
            end
        end
    end

    if not sourceSide then
        error("Error: No printer detected. Please connect a printer.")
    end

    if not destinationSide then
        error("Error: No container detected. Please connect a chest or similar container.")
    end

    return sourceSide, destinationSide
end

-- Function to move printed items from printer to container
function movePrintedItem(sourceSide, destinationSide)
    local printerSlot = 3  -- The 3D printer outputs printed items to slot 3
    local movedItems = transposer.transferItem(sourceSide, destinationSide, 64, printerSlot)

    if movedItems > 0 then
        print("Successfully moved " .. movedItems .. " item(s) from printer to container.")
    else
        print("No items found in the printer's output slot.")
    end
end

-- Main function to handle the entire print and transfer process
function customPrint()
    local models = loadModels(modelsFile)
    
    if #models == 0 then
        print("No models found in " .. modelsFile)
        return
    end

    print("Which item would you like to print?")
    for i, model in ipairs(models) do
        print(i .. ". " .. model.name)
    end

    io.write("Enter the index of the model you want to print: ")
    local choice = tonumber(io.read())
    
    if not choice or choice < 1 or choice > #models then
        print("Invalid choice.")
        return
    end

    io.write("How many would you like to print? ")
    local quantity = tonumber(io.read())
    
    if not quantity or quantity <= 0 then
        print("Invalid quantity.")
        return
    end

    local selectedModel = models[choice]
    local modelFile = selectedModel.file
    
    local scriptPath = filesystem.path(os.getenv("_")) or "/home/"
    local fullPath = filesystem.concat(scriptPath, modelFile)

    if not fileExists(fullPath) then
        print("Error: Model file " .. fullPath .. " does not exist.")
        return
    end

    local sourceSide, destinationSide = detectInventories()

    for i = 1, quantity do
        print("Starting print job " .. i .. " for model " .. selectedModel.name)

        waitForPrinter()
        os.execute("print3d " .. fullPath .. " > /dev/null 2>&1")
        print("Print job " .. i .. " submitted.")

        waitForPrinter()
        movePrintedItem(sourceSide, destinationSide)
    end

    print("All print jobs completed.")
end

-- Run the main function
customPrint()
