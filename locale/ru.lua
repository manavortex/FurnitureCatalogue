local filterDisabled = "disables this filter"
local strings = {
  -- ////// START : DON'T REMOVE THIS LINE

  -- ////// END   : DON'T REMOVE THIS LINE
}

for stringId, stringValue in pairs(strings) do
  ZO_CreateStringId(stringId, stringValue)
  SafeAddVersion(stringId, 1)
end
