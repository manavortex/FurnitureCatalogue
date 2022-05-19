-- ruthlessly stolen from TextureIt
function FurC.SortTable(tTable, sortKey, SortOrderUp)
  local keys = {}
  for k in pairs(tTable) do table.insert(keys, k) end
  table.sort(keys, function(a, b)
    if nil == tTable[a] or nil == tTable[b] then

    elseif nil == tTable[a][sortKey] then
            return false
    elseif nil == tTable[b][sortKey] then
            return true
    else
      if SortOrderUp then
        return tTable[a][sortKey] > tTable[b][sortKey]
      else
        return tTable[a][sortKey] < tTable[b][sortKey]
      end
    end

  end)

  local ret = {}
  local scannedLinks = {}
  local itemLink, entry
  for _, k in ipairs(keys) do
    entry = tTable[k]
    itemLink = entry["itemLink"]
    ingredients = entry["ingredients"]
    local index = scannedLinks[itemLink] or k

    table.insert(ret, entry)
  end

  return ret
end
