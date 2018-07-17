local rules = {} -- this line will be replaced by the generated rules definitions

local lookup = {}
for ruleType, rulesArray in pairs(rules) do
  lookup[ruleType] = {}
  for _, rule in ipairs(rulesArray) do
    lookup[ruleType][rule] = true
  end
end

local function getType(suffix)
  for ruleType, ruleLookup in pairs(lookup) do
    if ruleLookup[suffix] ~= nil then
      return ruleType
    end
  end
  return nil, "suffix '"..tostring(suffix).."' not found"
end

local function exists(suffix)
  return getType(suffix) ~= nil
end

local function isICANN(suffix)
  return lookup.icann[suffix] ~= nil
end

local function isPrivate(suffix)
  return lookup.private[suffix] ~= nil
end

return {
  exists = exists,
  getType = getType,
  isICANN = isICANN,
  isPrivate = isPrivate,
  rules = rules
}
