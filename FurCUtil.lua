--- Merges Table2 into Table1, mutates Table1 inplace and replaces its values if they have the same key. Example: merge({a="1",b="3"},{b="2"}) => {a="1",b="2"}
--- @param t1 any
--- @param t2 any
--- @see ZO_CombineNonContiguousTables (for no entry replacement)
--- @return table
function FurC.MergeTable(t1, t2)
  if nil == t2 and nil == t1 then
    return {}
  elseif nil == t2 then
    return t1
  elseif nil == t1 then
    return t2
  end

  for k, v in pairs(t2) do
    t1[k] = v
  end
  return t1
end

-- ruthlessly stolen from TextureIt
-- ToDo: ZO_TableOrderingFunction
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
