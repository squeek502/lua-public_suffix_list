if #arg < 1 then
  print(string.format("Usage: %s %s <version> [luarocks_rev=1]", arg[-1], arg[0]))
  return
end

local VERSION = arg[1]
local VER_LUAROCKS_REV = tonumber(arg[2]) or 1
local VER_TAG = VERSION:match("(%d+%.%d+)")

local outputPath = "public_suffix_list-"..VERSION.."-"..VER_LUAROCKS_REV..".rockspec"
local inputPath = "public_suffix_list.in.rockspec"

-- ensure the input file exists and load it
local infile = io.open(inputPath, "r")
if not infile then error(inputPath .. " not found") end
local input = infile:read("*a")
infile:close()

local output = input:gsub("%%VERSION%%", VERSION):gsub("%%VER_TAG%%", VER_TAG):gsub("%%VER_LUAROCKS_REV%%", VER_LUAROCKS_REV)

local outputFile = io.open(outputPath, "w+")
if not outputFile then error("failed to open " .. outputPath .. " for writing") end
outputFile:write(output)
outputFile:close()

print("Wrote rockspec to " .. outputPath)
