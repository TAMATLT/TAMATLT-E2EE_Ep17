--Function that prints errors to a file called error_log.txt 
--instead of a screen for debugging purposes
local args = {...}
local scriptName = args[1]

if not scriptName then
  print("Usage: runScript <script_name> <script_arguments...>")
  return
end

local function handleError(err)
  local file = io.open("error_log.txt", "a")
  if file then
    file:write(err .. "\n")
    file:close()
    print("Error logged to error_log.txt")
  else
    print("Error opening error log file: " .. err)
  end
end


local function logScriptStart(scriptName, scriptArgs)
    local file = io.open("error_log.txt", "a")
    if file then
        local argString = ""
        if scriptArgs then
            argString = table.concat(scriptArgs, " ") -- Concatenate arguments with spaces
        end

      file:write("----------------------------------------\n")
      file:write("Starting script: " .. scriptName .. " " .. argString .. "\n")  -- Log script name and args
      file:write("----------------------------------------\n")
      file:close()
    end
end


local ok, chunk = pcall(loadfile, scriptName)

if not ok then
    handleError(chunk)
elseif type(chunk) == "function" then
    local scriptArgs = {}
    if #args > 1 then
        for i = 2, #args do
            scriptArgs[i-1] = args[i]
        end
    end

    logScriptStart(scriptName, scriptArgs) -- Log before running the script

    local ok, result = pcall(chunk, table.unpack(scriptArgs))
    if not ok then
        handleError(result)
    elseif result then
        print(result)
    end
end