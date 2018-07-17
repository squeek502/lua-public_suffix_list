--[[

This script needs public_suffix_list.dat in the same directory.
You can get public_suffix_list.dat from one of the following locations:

https://raw.githubusercontent.com/publicsuffix/list/HEAD/public_suffix_list.dat
https://publicsuffix.org/list/public_suffix_list.dat

]]

local path = "public_suffix_list.dat"
local outputPath = "public_suffix_list.lua"
local inputPath = "public_suffix_list.in.lua"

-- ensure the list exists
local file = io.open(path, "rb")
if not file then error(path .. " not found, download it from:\n\n  https://publicsuffix.org/\n") else file:close() end

-- ensure the input file exists and load it
local infile = io.open(inputPath, "r")
if not infile then error(inputPath .. " not found") end
local input = infile:read("*a")
infile:close()

--[[
The Public Suffix List consists of a series of lines, separated by \n.

Each line is only read up to the first whitespace; entire lines can also be commented using //.

Each line which is not entirely whitespace or begins with a comment contains a rule.

A rule may begin with a "!" (exclamation mark). If it does, it is labelled as a "exception rule" and
then treated as if the exclamation mark is not present.
]]

local rules = {}
local curType = nil
for line in io.lines(path) do
  if line:match("BEGIN (.+) DOMAINS") then
    assert(curType == nil)
    curType = line:match("BEGIN (.+) DOMAINS")
  elseif line:match("END (.+) DOMAINS") then
    local endingType = line:match("END (.+) DOMAINS")
    assert(curType == endingType)
    curType = nil
  end

  line = line:match("^%s*(.*)")

  if #line > 0 and line:sub(1,2) ~= "//" then
    assert(curType ~= nil)
    if rules[curType] == nil then
      rules[curType] = {}
    end
    table.insert(rules[curType], line)
  end
end

local arrayToString
local function serialize(v)
  if type(v) == "table" then return arrayToString(v) end
  if type(v) == "string" then return '"' .. v .. '"' end
  return tostring(v)
end
function arrayToString(tbl)
  local str = "{"
  for k,v in ipairs(tbl) do
    str = str .. serialize(v)
    str = str .. ','
  end
  if str:sub(-1) == ',' then str = str:sub(1, -2) end
  return str .. "}"
end

local serialized = {"local rules = {}"}
for k, v in pairs(rules) do
  table.insert(serialized, string.format("rules.%s = %s", k:lower(), serialize(v)))
end
serialized = table.concat(serialized, "\n")

local outputFile = io.open(outputPath, "w+")
if not outputFile then error("failed to open " .. outputPath .. " for writing") end

-- replace the first line of the input with the serialized array
local output = input:gsub("[^\r\n]*", serialized, 1)

outputFile:write(output)
outputFile:close()

print("Wrote serialized public suffix list to " .. outputPath)
